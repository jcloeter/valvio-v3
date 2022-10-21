export interface Pitch {
    id: string;
    noteLetter: string;
    accidental: string;
    octave: number;
    position: string;
    midiNumber: number;
    instanceId: string | undefined;
    imageId: string | null;
}
