export interface Pitch {
    pitchId : string,
    noteLetter: string,
    accidental: string,
    octave: number,
    position: number,
    midiNumber : number,
    instanceId : string | undefined;
    imageId: string | null;
}