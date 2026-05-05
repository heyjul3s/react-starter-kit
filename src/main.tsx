import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { createRouter, RouterProvider } from "@tanstack/react-router";
import { routeTree } from "./route-tree.gen";

const router = createRouter({ routeTree });

declare module "@tanstack/react-router" {
  interface Register {
    router: typeof router;
  }
}

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <RouterProvider router={router} />
  </StrictMode>,
);

{
  /* <MaybeParent
    condition={import.meta.env === "development" || import.meta.env === "dev"}
    Parent={(children) => <StrictMode>{children}</StrictMode>}
  >
    <RouterProvider router={router} />
  </MaybeParent>, */
}
