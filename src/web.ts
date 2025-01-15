import { WebPlugin } from '@capacitor/core';

import type { LoginWithUAEPassPlugin } from './definitions';

export class LoginWithUAEPassWeb extends WebPlugin implements LoginWithUAEPassPlugin {
  initialize(options: { clientId: string; clientSecret: string; environment: "production" | "qa" | "dev"; redirectUri: string; scope: string; state: string; successScheme: string; failScheme: string; signingScope: string; }): Promise<void> {
    return new Promise((resolve) => {
      console.log('Web initialize called with options:', options);
      // Simulate initialization logic
      resolve();
    });
  }
  async login(): Promise<{ accessToken: string; userInfo: { uuid: string; firstName: string; lastName: string; email: string; }; }> {
    console.log('Web login called');

    const ANDROID_LINK = 'https://roomi-app-dev.vercel.app/login';
    const UAEPASS_SCOPE = 'scope=urn:uae:digitalid:profile:general urn:uae:digitalid:profile:general:profileType urn:uae:digitalid:profile:general:unifiedId'

    const baseParams = new URLSearchParams({
      response_type: 'code',
      client_id: 'sandbox_stage',
      scope: UAEPASS_SCOPE,
      state: "HnlHOJTkTb66Y5H",
      redirect_uri: ANDROID_LINK
    });

    const uaePassUrl = `https://stg-id.uaepass.ae/idshub/authorize?${baseParams.toString()}&acr_values=urn:safelayer:tws:policies:authentication:level:low`;

    window.location.href = uaePassUrl;

    return {
      accessToken: 'dummyAccessToken',
      userInfo: {
        uuid: 'dummyUUID',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com'
      }
    };
  } 

  async logout(): Promise<void> {
    console.log('Web logout called');
  }
}
