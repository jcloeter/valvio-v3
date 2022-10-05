import {convertPitchInstrumentIdToImageId} from "../components/ui/convertPitchInstrumentIdToImageId";

export const createImageUrlFromPitchId = (pitchId: string): string => {
    const imageId = convertPitchInstrumentIdToImageId(pitchId);
    //TODO: replace url with .env dynamic variable
    return `https://valvio-data-bucket.s3.us-east-2.amazonaws.com/valvio_pitches/${imageId}_treble.png`;
}