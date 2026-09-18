export default async function handler(req, res) {
  if (req.method !== "GET") {
    return res.status(405).json({
      error: "Method not allowed",
    });
  }

  const { appid } = req.query;

  if (!appid || !/^\d+$/.test(String(appid))) {
    return res.status(400).json({
      error: "Invalid AppID",
    });
  }

  const targetUrl =
    `https://api.ryzennetworking.duckdns.org/api/download/${appid}`;

  try {
    const response = await fetch(targetUrl);

    if (!response.ok) {
      return res.status(response.status).send(
        await response.text()
      );
    }

    const contentType =
      response.headers.get("content-type") ||
      "application/octet-stream";

    const contentLength =
      response.headers.get("content-length");

    const contentDisposition =
      response.headers.get("content-disposition");

    res.setHeader("Content-Type", contentType);
    res.setHeader("Cache-Control", "no-store");

    if (contentLength) {
      res.setHeader("Content-Length", contentLength);
    }

    if (contentDisposition) {
      res.setHeader(
        "Content-Disposition",
        contentDisposition
      );
    }

    const buffer = Buffer.from(
      await response.arrayBuffer()
    );

    return res.status(200).send(buffer);
  } catch (error) {
    console.error(error);

    return res.status(502).json({
      error: "Failed to connect to RyzenAPI",
    });
  }
}
