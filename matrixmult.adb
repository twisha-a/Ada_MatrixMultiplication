with Text_Io;
use  Text_Io;

with Ada.Integer_Text_IO;
use  Ada.Integer_Text_IO;


package body MatrixMult is
-- MatMult(A,B,C) as shown below A and B are input parameters and C will be our output parameters
	procedure MatMult(A: in Matrix; B: in Matrix; C: out Matrix) is

		task type Mult_Worker is
			entry Mult_Cell(A_x : in INTEGER;
							B_y : in INTEGER);
			entry Completed(Ans : out INTEGER);
		end Mult_Worker;
--  Taking x, y as the cordinates of the matrix representing rows and columns respectively
		task body Mult_Worker is
			Sum 	: INTEGER := 0;
			x		: INTEGER;
			y 		: INTEGER;
		begin
			accept Mult_Cell(A_x : in INTEGER;
							 B_y : in INTEGER) do
				x 	:= A_x;
				y 	:= B_y;
			end Mult_Cell;
-- we will get a sum for C(x,y) by traversing across row x of A and column y of B
			for i in 1 .. SIZE loop
				Sum := Sum + A(x, i) * B(i, y);
			end loop;

			accept Completed(Ans : out INTEGER) do
				Ans := Sum;
			end Completed;
		end Mult_Worker;
		-- Matrix of worker tasks to perform multiplication in parallel for each cell of resultant matrix C
		Workers : array(1 .. SIZE, 1 .. SIZE) of Mult_Worker;

	begin
		-- Initialize each worker task with corresponding x and y coordinates
		for x in 1 .. SIZE loop
			for y in 1 .. SIZE loop
				Workers(x, y).Mult_Cell(x, y);
			end loop;
		end loop;

		-- Retrieve computed results from each worker task and store them in matrix C
		for x in 1 .. SIZE loop
			for y in 1 .. SIZE loop
				Workers(x, y).Completed(C(x, y));
			end loop;
		end loop;
	end MatMult;

end MatrixMult;