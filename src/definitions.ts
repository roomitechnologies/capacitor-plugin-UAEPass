export interface LoginWithUAEPassPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
