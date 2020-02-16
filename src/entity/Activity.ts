import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    CreateDateColumn,
    UpdateDateColumn,
    ManyToOne
  } from "typeorm";
  import { Length, IsNotEmpty } from "class-validator";
  import {User} from "./User";
  
  @Entity()
  export class Activity {
    @PrimaryGeneratedColumn()
    id: number;
  
    // Type of activity
    @Column()
    type: number;
  

    // Name of activity
    @Column()
    @Length(1, 100)
    name: string;

    @Column()
    userId: number;

    // User who performed activity 
    @ManyToOne(type => User, user => user.activity)
    user: User;


    // Description of activity
    @Column()
    @Length(1, 500)
    description: string;


    // Duration of activity in milliseconds
    @Column()
    duration: number;

    // Position parameters of activity 
    @Column()
    latitude: string;

    @Column()
    longtitude: string;

    // Creation date
    @Column()
    @CreateDateColumn()
    createdAt: Date;
  
    // Update date 
    @Column()
    @UpdateDateColumn()
    updatedAt: Date;
  
  }