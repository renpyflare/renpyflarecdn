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
    `https://raw.githubusercontent.com/skyflarefox/Skyapi/main/${appid}.zip`;

  try {
    const response = await fetch(targetUrl);

    if (!response.ok) {
      return res.status(response.status).send(
        await response.text()
      );
    }

    const contentLength =
      response.headers.get("content-length");

    res.setHeader(
      "Content-Type",
      response.headers.get("content-type") ||
        "application/zip"
    );

    res.setHeader(
      "Content-Disposition",
      `attachment; filename="${appid}.zip"`
    );

    res.setHeader("Cache-Control", "no-store");

    if (contentLength) {
      res.setHeader("Content-Length", contentLength);
    }

    const buffer = Buffer.from(
      await response.arrayBuffer()
    );

    return res.status(200).send(buffer);
  } catch (error) {
    console.error(error);

    return res.status(502).json({
      error: "Failed to connect to SkyAPI",
    });
  }
}
