import {Transposition} from "./Transposition";

export interface Quiz {
    id: number,
    name: string,
    difficulty: string,
    level: number,
    description: string,
    length: number,
    transposition: Transposition,
}