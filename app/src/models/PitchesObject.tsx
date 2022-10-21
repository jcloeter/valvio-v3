import { Pitch } from './Pitch';

export interface PitchesObject {
    quizPitchId: number;
    originalPitch: Pitch;
    transposedAnswer: Pitch | null;
    instanceId: string | null;
}
