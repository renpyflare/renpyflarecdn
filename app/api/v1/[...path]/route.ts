import { NextResponse } from "next/server";

export async function GET(
  _request: Request,
  { params }: { params: Promise<{ path: string[] }> }
) {
  const { path } = await params;

  if (!path || path.length !== 2) {
    return NextResponse.json(
      { error: "Endpoint inválido" },
      { status: 400 }
    );
  }

  const [api, appid] = path;

  if (!appid || !/^\d+$/.test(appid)) {
    return NextResponse.json(
      { error: "AppID inválido" },
      { status: 400 }
    );
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
      return NextResponse.json(
        { error: "API não encontrada" },
        { status: 404 }
      );
  }

  try {
    const response = await fetch(targetUrl, {
      method: "GET",
      redirect: "follow",
      cache: "no-store",
    });

    if (!response.ok) {
      return new NextResponse(response.body, {
        status: response.status,
        headers: {
          "Content-Type":
            response.headers.get("content-type") ||
            "application/octet-stream",
        },
      });
    }

    const headers = new Headers();

    const contentType = response.headers.get("content-type");
    const contentLength = response.headers.get("content-length");
    const contentDisposition = response.headers.get("content-disposition");

    if (contentType) {
      headers.set("Content-Type", contentType);
    }

    if (contentLength) {
      headers.set("Content-Length", contentLength);
    }

    if (contentDisposition) {
      headers.set("Content-Disposition", contentDisposition);
    }

    headers.set("Cache-Control", "no-store");

    return new NextResponse(response.body, {
      status: 200,
      headers,
    });
  } catch {
    return NextResponse.json(
      { error: "Falha ao acessar a origem" },
      { status: 502 }
    );
  }
}
