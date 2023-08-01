{-
Two players choose one of Rock, Paper and Scissors after counting to three by making
one of these gestures:
• A clenched fist which represents a rock.
• A flat hand representing a piece of paper.
• Index and middle figure extended which represents a pair of scissors.
If they choose the same gesture, neither wins; if not, the result is decided this way:
• Rock defeats scissors, because a rock will blunt a pair of scissors.
• Paper defeats rock, because a paper can wrap up a rock.
• Scissors defeat paper, because scissors cut paper.
-}

data Move = Rock | Paper | Scissors
  deriving (Show, Eq)

beat :: Move -> Move -- Quem ganha do move
beat Rock = Paper
beat Paper = Scissors
beat Scissors = Rock

lose :: Move -> Move -- Quem perde pro move
lose Rock = Scissors
lose Paper = Rock
lose Scissors = Paper

score :: Move -> Move -> Integer
score Rock Rock = 0
score Rock Paper = -1
score Rock Scissors = 1
score Paper Paper = 0
score Paper Scissors = -1
score Paper Rock = 1
score Scissors Scissors = 0
score Scissors Rock = -1
score Scissors Paper = 1