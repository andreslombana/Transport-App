import { TimeAndDistanceValues } from './time_and_distance_values.entity';
import { Repository } from 'typeorm';
export declare class TimeAndDistanceValuesService {
    private timeAndDistanceValuesRepository;
    constructor(timeAndDistanceValuesRepository: Repository<TimeAndDistanceValues>);
    find(): Promise<TimeAndDistanceValues[]>;
}
