export interface LoginWithUAEPassPlugin {
  initialize(options: {
    clientId: string;
    clientSecret: string;
    environment: 'production' | 'qa' | 'dev';
    redirectUri: string;
    scope: string;
    state: string;
    successScheme: string;
    failScheme: string;
    signingScope: string;
  }): Promise<void>;
  login(): Promise<{
    accessToken: string;
    userInfo: {
      uuid: string;
      firstName: string;
      lastName: string;
      email: string;
      // Add other user info fields as needed
    };
  }>;
}

export interface UAEPassOptions {
  redirectUri: string;
}
