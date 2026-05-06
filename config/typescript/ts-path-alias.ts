import path from 'path';
import tsconfig from '../../tsconfig.json' assert { type: 'json ' };

export function tsPathAlias(): Record<string, string> {
  const paths = (tsconfig as any)?.compilerOptions?.paths as Record<string, string[]> | undefined;

  if (!paths || Object.keys(paths).length === 0) {
    return {};
  }

  return Object.keys(paths).reduce<Record<string, string>>((acc, alias) => {
    const targets = paths[alias];

    if (!targets || targets.length === 0) {
      return acc;
    }

    const key = alias.replace(/\/\*$/u, '');
    const rawTarget = String(targets[0]).replace(/\/\*$/u, '');

    acc[key] = path.resolve(process.cwd(), rawTarget);
    return acc;
  }, {});
}
