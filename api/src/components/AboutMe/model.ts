import * as connections from '@/config/connection/connection';
import { Document, Schema } from 'mongoose';

/**
 * @export
 * @interface IAboutMeRequest
 */
export interface IAboutMeRequest {
    id: string;
    name: string;
}

/**
 * @export
 * @interface IAboutMeModel
 * @extends {Document}
 */
export interface IAboutMeModel extends Document {
    name: string;
    birthday: number;
    nationality: string;
    job: string;
    github: string;
}

export type AuthToken = {
    accessToken: string;
    kind: string;
};


const AboutMeSchema: Schema = new Schema(
    {
        name: String,
        birthday: Number,
        nationality: String,
        job: String,
        github: String
    },
    {
        collection: 'profile',
        versionKey: false,
    }
)


export default connections.db.model<IAboutMeModel>('AboutMeModel', AboutMeSchema);
