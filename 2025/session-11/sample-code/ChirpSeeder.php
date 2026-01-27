<?php

namespace Database\Seeders;

use App\Models\Chirp;
use App\Models\User;
use Illuminate\Database\Seeder;

class ChirpSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $seed_chirps = [
                ['message' => "How do you keep a Rhino from charging?
Take away its credit card."],
                ['message' => "How many actors does it take to change a light bulb?
Only one-they don't like to share the spotlight."],
                ['message' => "How many aerobics instructors does it take to change a lightbulb ?
Five.
Four to do it in perfect synchrony and one to stand there going, \"To the left, and to the left, and to the left, and to the left, and take it out, and put it down, and pick it up, and put it in, and to the right, and to the right, and to the right, and to the right...\""],
                ['message' => "How many auto mechanics does it take to change a light bulb?
Six - One to force it with a hammer and five to go out for more bulbs."],
                ['message' => "How many law professors does it take to change a lightbulb?
Hell, you need 250 just to lobby for the research grant."],
                ['message' => "**Diplomacy:** The ability to tell a person to go to hell in such a way that they look forward to the trip."],
                ['message' => "Why didn't the skeleton go to the dance?
Because it had no body to go with."],
                ['message' => "Knock, Knock.
Who's there?
Cows go.
Cows go who?
No, silly! Cows go moo!"],
                ['message' => "What is represented by `WOWOLFOL`?
Wolf in sheep\'s clothing (wool)!"],
                ['message' => "_Teacher:_ John, where are the Great Plains?
_John:_ At the airport."],
                ['message' => "What do you call a dog in the sun?
A Hot Dog!"],
                ['message' => "
A. Regular Rocks are too heavy!"],
                ['message' => "How many country singers does it take to screw in a light bulb?
1 to screw it in, and 3 to write a song about it."],
                ['message' => "What do you get when you cross a snake and a kangaroo?
A jump rope"],
                ['message' => "How many psychologists does it take to change a light bulb?
Only one, but the bulb has got to WANT to change."],
                ['message' => "How many surrealists does it take to change a light bulb?
Fish!"],
                ['message' => "How many actors does it take to change a light bulb?
Only one-they don\'t like to share the spotlight."],
                ['message' => "How many aerobics instructors does it take to change a lightbulb?
Five. Four to do it in perfect synchrony and one to stand there going \"To the left, and to the left, and to the left, and to the left, and take it out, and put it down, and pick it up, and put it in, and to the right, and to the right, and to the right, and to the right...\""],
                ['message' => "How many auto mechanics does it take to change a light bulb?
Six - One to force it with a hammer and five to go out for more bulbs."],
                ['message' => "How many FBI agents does it take to change a lightbulb?
Shut up! We\'ll be asking the questions here."],
                ['message' => "How many philosophers does it take to change a lightbulb?
3. One to change it and the other two to argue whether the lightbulb really exists."],
                ['message' => "How many telemarketers does it take to change a light bulb?
Only one, but he has to do it while you\'re eating dinner."],
                ['message' => "What\'s the difference between a dry cleaner and a lawyer?
The cleaner pays if he loses your suit.
A lawyer can lose your suit and still take you to the cleaners."],
                ['message' => "How many managers does it take to change a light bulb?
W\'ve formed a task force to study the problem of why light bulbs burn out and to figure out what, exactly, we as supervisors can do to make the bulbs work smarter, not harder."],
                ['message' => "How many shipping department personnel does it take to change a light bulb?
We can change the bulb in seven to ten working days,
but if you call before 2 p.m. and pay an extra $15, we can get it changed overnight."],
                ['message' => "How many management information services guys does it take to change a light bulb?
MIS has received your request concerning your hardware problem and has assigned you request number 39712.
Please use this number for any future reference to the light bulb issue."],
                ['message' => "What is the definition of a sick bird?
Illegal"],
                ['message' => "What do you get when you cross a kangaroo and a sheep?
A sweater with pockets"],
            ];

        $users = User::all()->pluck('id','id')->toArray();

        foreach ($seed_chirps as $newChirp){
            $newChirp['user_id'] = array_rand( $users);
            Chirp::create($newChirp);
        }

    }
}
