interface DanceMove {
  moves?: DanceMove[];
  numOfMoves: number;
  name: string;
  perform: (moveId: number) => boolean;
}

const chachaslide: DanceMove = {} as DanceMove;
chachaslide.numOfMoves = 2;
