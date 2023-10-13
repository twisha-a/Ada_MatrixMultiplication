with Ada.Command_Line, Text_Io, Ada.Integer_Text_IO, MatrixMult;
use  Ada.Command_Line, Text_Io, Ada.Integer_Text_IO, MatrixMult;


procedure AssignmentMain is
	--a task type for reading a matrix from standard input
   	task type Matrix_Reader is
   		entry Read_Matrix(M : out MatrixMult.Matrix);
   	end Matrix_Reader;
   	task body Matrix_Reader is
   		Next_Int : INTEGER;
		--range of x and y
   		y, x : INTEGER range 1 .. MatrixMult.SIZE := 1;
   	begin
   		loop
   			select
   				accept Read_Matrix(M : out MatrixMult.Matrix) do
   					y  := 1;
   					x  := 1;
	   				while not Text_Io.End_Of_File or x <= MatrixMult.SIZE loop
						Get(Next_Int);
						M(x, y) := Next_Int;
						--comparing the value of y 
						if y  < MatrixMult.SIZE then
							y  := y + 1;
						else
							y  := 1;
							if x + 1 > MatrixMult.SIZE then
								exit;
							end if;
							x := x + 1;
						end if;
					end loop;
   				end Read_Matrix;
   			or
   				terminate;
   			end select;
   		end loop;
   	end Matrix_Reader;
	-- a task type for printing a matrix to standard output
   	task type Matrix_Printer is
   		entry Print(M : in MatrixMult.Matrix);
   	end Matrix_Printer;

   	task body Matrix_Printer is
   		y, x : INTEGER range 1 .. MatrixMult.SIZE := 1; -- x, y coordinates to navigate the matrix
   	begin
   		loop
   			select
   				accept Print(M : in MatrixMult.Matrix) do
   					y := 1;  -- Initialize coordinates
   					x := 1;
					-- Loop until the entire matrix is printed
   					while x <= MatrixMult.SIZE loop
   						Put(M(x, y));
						if y < MatrixMult.SIZE then
							y := y + 1; -- Move to the next column if possible
						else
							New_Line; -- Move to the next line after printing a row
							y := 1; -- Reset column and move to the next row
							if x + 1 > MatrixMult.SIZE then
								exit; -- exit when entire matrix has been printed
							end if;
							x := x + 1;
						end if;
   					end loop;
   				end Print;
   			or
   				terminate;
   			end select;
   		end loop;
   	end Matrix_Printer;

   	Reader1, Reader2 : Matrix_Reader;
   	Printer : Matrix_Printer;

   	A, B, C : MatrixMult.Matrix := (others => (others => 0));
-- we Reader1 and Reader2 of SIZE^2 integers and we areading them into Matrix A and Matrix B respectively
begin
	Reader1.Read_Matrix(A);
	Reader2.Read_Matrix(B);

	MatMult(A, B, C);
	-- Printer will print the Third Matrix which is Matrix C 
	Printer.Print(C);
end AssignmentMain;