export const getAccidentalSignFromName = (name: string) => {
    if (name === 'flat') {
        return '♭';
    }
    if (name === 'double-flat') {
        return '♭♭';
    }
    if (name === 'sharp') {
        return '♯';
    }
    if (name === 'double-sharp') {
        return '𝄪';
    }
    if (name === 'natural') {
        return '♮';
    }
};
