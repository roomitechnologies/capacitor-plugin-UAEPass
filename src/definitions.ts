export interface LoginWithUAEPassPlugin {
  login(options: UAEPassOptions): Promise<{ token: string }>;
  logout?(): Promise<void>;
}

export interface UAEPassOptions {
  redirectUri: string;
}
