

def setup_next_dirs():
	next_dirs = [[]] * 6
	for d in xrange(6):
		axis = (d, (5 - d))
		next_dirs[d] = [n for n in xrange(6) if n not in axis]
		pass 
	return next_dirs

next_dirs = setup_next_dirs()

cell_skip = [1, 5, 25, -25, -5, -1]

def setup_cube_cells():
	cube_cells = (5 * 5 * 5) * [99]
	p2 = cell_skip[2]
	for i2 in xrange(3):
		p1 = p2 + cell_skip[1]
		for i1 in xrange(3):
			p0 = p1 + cell_skip[0]
			for i0 in xrange(3):
				cube_cells[p0] = 0
				p0 += cell_skip[0]
				pass
			p1 += cell_skip[1]
			pass
		p2 += cell_skip[2]
		pass
	return cube_cells

cube_cells = setup_cube_cells()

def print_cube_cells():
	p = 0
	for i2 in xrange(5):
		for i1 in xrange(5):
			for i3 in xrange(5):
				print "%3d" % (cube_cells[p],),
				p += 1
				pass
			print
			pass
		print
		pass
	return 

cube_chain = [2, 1, 1, 2, 1, 2, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 2]

def turn_chain(ic, p, d, t):
	if ic >= len(cube_chain):
		print_cube_cells()
	else:
		n = cube_chain[ic]
		for dd in next_dirs[d]:
			strait_chain(ic, p, dd, n, t)
			pass
		pass
	return
	
def strait_chain(ic, p, d, n, t):
	if n > 0:
		strait_chain2(ic, p + cell_skip[d], d, n, t)
	else:
		turn_chain(ic + 1, p, d, t)
		pass
	return 

def strait_chain2(ic, p, d, n, t):
	if cube_cells[p] == 0:
		cube_cells[p] = t
		strait_chain(ic, p, d, n - 1, t + 1)
		cube_cells[p] = 0
		pass
	return 

def solve_cube():
	p = cell_skip[0] + cell_skip[1] + cell_skip[2]
	t = 1
	cube_cells[p] = t
	ic = 0
	d = 0
	strait_chain(ic, p, d, cube_chain[ic], t + 1)
	return

def main():
	solve_cube()
	return

main()

