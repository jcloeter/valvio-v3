export interface User {
    displayName: string | null,
    isAuthenticated: boolean,
    email: string | null,
    emailVerified: boolean,
    isAnonymous: boolean,
    phoneNumber: string | null,
    photoUrl: string | null,
    providerId: string | null,
    refreshToken: string | null,
    tenantId: string | null,
    uid: string | null,
    createdAt: string | null,
    creationTime: string | null,
    lastLoginAt: string | null,
    lastSignInTime: string | null
    isNewUser: boolean,
}