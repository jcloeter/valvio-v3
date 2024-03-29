import {PitchesObject} from '../models/PitchesObject';

export const randomizeAndExtendPitchArray = (pitches: PitchesObject[], quizLength: number, quizDescription: string | null): PitchesObject[] => {
    const shallowCopyPitches = pitches.slice();

    if (quizDescription === "Scale"){
        return addIdToPitchArray(pitches);
    }

    const shuffledPitches = shallowCopyPitches.sort((a, b) => 0.5 - Math.random());

    const shuffledAndExpandedArray: PitchesObject[] = expandPitchArray(shuffledPitches);

    const shuffledExpandedAndIdArray = addIdToPitchArray(shuffledAndExpandedArray);

    const reShuffledExpandedAndIdArray = shuffledExpandedAndIdArray.sort((a, b) => 0.5 - Math.random());

    const nonRepeatedPitchesArray: PitchesObject[] = [];
    reShuffledExpandedAndIdArray.map((pitch: PitchesObject, i, origArr) => {
        if (!origArr[i + 1]) return false;
        if (pitch.originalPitch.id !== origArr[i + 1].originalPitch.id) {
            nonRepeatedPitchesArray.push(pitch);
        }
    });


    if (nonRepeatedPitchesArray.length < quizLength) {
        throw new Error('Malfunction in creating quiz from pitch objects! Quiz is too short');
    }

    return nonRepeatedPitchesArray.slice(0, quizLength);
};

const expandPitchArray = (array: PitchesObject[]): PitchesObject[] => {
    let expandedArray = [];

    for (let x = 0; x < 5; x++){
        expandedArray.push(...array)
    }

    return expandedArray;
};

const addIdToPitchArray=(pitchArray: Array<PitchesObject>)=>{
    return pitchArray.map((pitch: PitchesObject) => {
        pitch.instanceId = Math.random().toString(36).substring(2, 40);
        return pitch;
    });
}
