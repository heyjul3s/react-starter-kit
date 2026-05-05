type MaybeProps = {
  children: React.ReactNode;
  condition: boolean;
  Parent: (children: React.ReactNode) => React.JSX.Element;
};

export function MaybeParent({ children, condition, Parent }: MaybeProps) {
  return condition ? Parent(children) : <>{children}</>;
}
