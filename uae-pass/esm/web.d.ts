import { WebPlugin } from '@capacitor/core';
import type { LoginWithUAEPassPlugin, UAEPassOptions } from './definitions';
export declare class LoginWithUAEPassWeb extends WebPlugin implements LoginWithUAEPassPlugin {
    login(options: UAEPassOptions): Promise<{
        token: string;
    }>;
    logout(): Promise<void>;
}
