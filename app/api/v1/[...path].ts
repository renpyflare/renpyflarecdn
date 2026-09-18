import type { VercelRequest, VercelResponse } from "@vercel/node";

export default async function handler(
  req: VercelRequest,
  res: VercelResponse
) {
  if (req.method !== "GET") {
    res.setHeader("Allow", "GET");
    return res.status(405).json({
      error: "Method not allowed",
    });
  }

  const path = req.query.path;

  const parts = Array.isArray(path)
    ? path
    : typeof path === "string"
      ? path.split("/")
      : [];

  if (parts.length !== 2) {
    return res.status(400).json({
      error: "Invalid endpoint",
      usage: [
        "/api/v1/ryzenapi/<appid>",
        "/api/v1/skyapi/<appid>",
      ],
    });
  }

  const [api, appid] = parts;

  if (!appid || !/^\d+$/.test(appid)) {
    return res.status(400).json({
      error: "Invalid AppID",
    });
  }

  let targetUrl: string;

  switch (api) {
    case "ryzenapi":
      targetUrl =
        `https://api.ryzennetworking.duckdns.org/api/download/${appid}`;
      break;

    case "skyapi":
      targetUrl =
        `https://raw.githubusercontent.com/skyflarefox/Skyapi/main/${appid}.zip`;
      break;

    default:
      return res.status(404).json({
        error: "API not found",
      });
  }

  try {
    const response = await fetch(targetUrl, {
      method: "GET",
      redirect: "follow",
    });

    res.statusCode = response.status;

    const contentType = response.headers.get("content-type");
    const contentLength = response.headers.get("content-length");
    const contentDisposition =
      response.headers.get("content-disposition");

    if (contentType) {
      res.setHeader("Content-Type", contentType);
    }

    if (contentLength) {
      res.setHeader("Content-Length", contentLength);
    }

    if (contentDisposition) {
      res.setHeader("Content-Disposition", contentDisposition);
    }

    res.setHeader("Cache-Control", "no-store");

    if (!response.body) {
      return res.end();
    }

    const buffer = Buffer.from(await response.arrayBuffer());

    return res.end(buffer);
  } catch {
    return res.status(502).json({
      error: "Failed to access upstream API",
    });
  }
}
