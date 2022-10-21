export interface User {
    displayName: string | null;
    isAuthenticated: boolean;
    email: string | null;
    emailVerified: boolean;
    isAnonymous: boolean;
    phoneNumber: string | null;
    photoUrl: string | null;
    providerId: string | null;
    refreshToken: string | null;
    tenantId: string | null;
    uid: string | null;
    creationTime: string | null | undefined;
    lastSignInTime: string | null | undefined;
    idToken: string | null | undefined;
}
