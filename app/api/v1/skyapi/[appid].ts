import type { VercelRequest, VercelResponse } from "@vercel/node";

export default async function handler(
  req: VercelRequest,
  res: VercelResponse
) {
  if (req.method !== "GET") {
    return res.status(405).json({
      error: "Method not allowed",
    });
  }

  const appid = req.query.appid;

  if (typeof appid !== "string" || !/^\d+$/.test(appid)) {
    return res.status(400).json({
      error: "Invalid AppID",
    });
  }

  const url =
    `https://raw.githubusercontent.com/skyflarefox/Skyapi/main/${appid}.zip`;

  try {
    const response = await fetch(url);

    if (!response.ok) {
      return res.status(response.status).send(
        await response.text()
      );
    }

    res.setHeader(
      "Content-Type",
      response.headers.get("content-type") ||
        "application/zip"
    );

    res.setHeader("Cache-Control", "no-store");

    const contentLength = response.headers.get("content-length");

    if (contentLength) {
      res.setHeader("Content-Length", contentLength);
    }

    const buffer = Buffer.from(await response.arrayBuffer());

    return res.status(200).send(buffer);
  } catch {
    return res.status(502).json({
      error: "Failed to connect to SkyAPI",
    });
  }
}
