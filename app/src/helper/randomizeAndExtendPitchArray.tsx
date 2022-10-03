import {Pitch} from "../models/Pitch";

export const randomizeAndExtendPitchArray = (pitches: Pitch[], quizLength: number): Pitch[] => {
    const shallowCopyPitches = pitches.slice();
    const shuffledPitches = shallowCopyPitches.sort((a, b) => 0.5 - Math.random());

    const shuffledAndExpandedArray: Pitch[] = expandPitchArray(shuffledPitches);


    const shuffledExpandedAndIdArray = shuffledAndExpandedArray.map((pitch: Pitch) => {
        pitch.instanceId = Math.random().toString(36).substring(2,40);
        return pitch;
    })

    return shuffledExpandedAndIdArray.slice(0, quizLength);

}

const expandPitchArray = (array: Pitch[]): Pitch[] => {
    array = array.concat(array);
    array = array.concat(array);
    array = array.concat(array);
    array = array.concat(array);
    return array;
}