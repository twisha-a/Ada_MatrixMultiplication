package MatrixMult is
	SIZE : constant := 10;
	subtype Matrix_Coordinate is INTEGER range 1 .. Size;
	type Matrix is array(1 .. SIZE, 1 .. SIZE) of INTEGER;
	procedure MatMult(A: in Matrix; B: in Matrix; C: out Matrix);
end MatrixMult;
