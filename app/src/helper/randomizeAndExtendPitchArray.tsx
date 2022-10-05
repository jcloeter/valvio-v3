import {PitchesObject} from "../models/PitchesObject";

export const randomizeAndExtendPitchArray = (pitches: PitchesObject[], quizLength: number): PitchesObject[] => {
    const shallowCopyPitches = pitches.slice();
    const shuffledPitches = shallowCopyPitches.sort((a, b) => 0.5 - Math.random());

    const shuffledAndExpandedArray: PitchesObject[] = expandPitchArray(shuffledPitches);

    const shuffledExpandedAndIdArray = shuffledAndExpandedArray.map((pitch: PitchesObject) => {
        pitch.instanceId = Math.random().toString(36).substring(2,40);
        return pitch;
    })

    //Todo: Eliminate repeated notes!
    const reShuffledExpandedAndIdArray = shuffledExpandedAndIdArray.sort((a, b)=>0.5 - Math.random());

    return reShuffledExpandedAndIdArray.slice(0, quizLength);

}

const expandPitchArray = (array: PitchesObject[]): PitchesObject[] => {
    array = array.concat(array);
    array = array.concat(array);
    array = array.concat(array);
    array = array.concat(array);
    return array;
}