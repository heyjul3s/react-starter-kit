import path from "path";
import tsconfig from "../../tsconfig.json" assert { type: "json " };

export function tsPathAlias() {
  const paths = tsconfig?.compilerOptions.paths;
  const pathAliases = Object.keys(paths);

  return pathAliases?.length
    ? pathAliases.reduce((configPaths, pathAlias) => {
        return {
          ...configPaths,
          [pathAlias]: path.resolve(__dirname, paths[`${pathAlias}`].at(0)),
        };
      }, {})
    : {};
}
