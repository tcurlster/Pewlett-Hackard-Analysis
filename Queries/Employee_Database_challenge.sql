select * FROM employees

--Create retirement_titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles 
FROM retirement_titles AS rt
WHERE to_date ='9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT COUNT(ut.emp_no) as employee_count, 
	ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY title
ORDER BY COUNT(title) DESC;

--Create mentorship eligibility table
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligbility
FROM employees AS e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') AND
	(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, ti.title ASC;