import { PitchesObject } from '../models/PitchesObject';

export const randomizeAndExtendPitchArray = (pitches: PitchesObject[], quizLength: number): PitchesObject[] => {
    const shallowCopyPitches = pitches.slice();
    const shuffledPitches = shallowCopyPitches.sort((a, b) => 0.5 - Math.random());

    const shuffledAndExpandedArray: PitchesObject[] = expandPitchArray(shuffledPitches);

    const shuffledExpandedAndIdArray = shuffledAndExpandedArray.map((pitch: PitchesObject) => {
        pitch.instanceId = Math.random().toString(36).substring(2, 40);
        return pitch;
    });

    const reShuffledExpandedAndIdArray = shuffledExpandedAndIdArray.sort((a, b) => 0.5 - Math.random());

    const nonRepeatedPitchesArray: PitchesObject[] = [];
    reShuffledExpandedAndIdArray.map((pitch: PitchesObject, i, origArr) => {
        if (!origArr[i + 1]) return false;
        if (pitch.originalPitch.id !== origArr[i + 1].originalPitch.id) {
            nonRepeatedPitchesArray.push(pitch);
        }
    });

    console.log(nonRepeatedPitchesArray);

    if (nonRepeatedPitchesArray.length < quizLength) {
        throw new Error('Malfunction in creating quiz from pitch objects! Quiz is too short');
    }

    return nonRepeatedPitchesArray.slice(0, quizLength);
};

const expandPitchArray = (array: PitchesObject[]): PitchesObject[] => {
    array = array.concat(array);
    array = array.concat(array);
    array = array.concat(array);
    array = array.concat(array);
    array = array.concat(array);
    return array;
};
