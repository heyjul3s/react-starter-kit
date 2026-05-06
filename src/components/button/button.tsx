import './button.css';

export type ButtonProps = {
  backgroundColor?: string;
  label: string;
  onClick?: () => void;
  primary?: boolean;
  size?: 'small' | 'medium' | 'large';
};

export function Button({
  backgroundColor,
  label,
  onClick,
  primary = false,
  size = 'medium',
}: ButtonProps) {
  const variantClassName = primary ? 'button--primary' : 'button--secondary';

  return (
    <button
      className={['button', `button--${size}`, variantClassName].join(' ')}
      onClick={onClick}
      style={{ backgroundColor }}
      type="button"
    >
      {label}
    </button>
  );
}
