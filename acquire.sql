USE 'giec';
SELECT
  authors.id 'id',
  authors.first_name 'first_name',
  authors.last_name 'last_name',
  GROUP_CONCAT(
    DISTINCT participations.ar
    ORDER BY participations.ar
    SEPARATOR ','
  ) 'assessment_reports',
  GROUP_CONCAT(
    DISTINCT participations.working_groups
    ORDER BY participations.ar
    SEPARATOR ','
  ) 'working_groups',
  GROUP_CONCAT(
    DISTINCT participations.chapters
    ORDER BY participations.ar
    SEPARATOR ','
  ) 'chapters',
  GROUP_CONCAT(
    DISTINCT participations.roles
    ORDER BY participations.ar
    SEPARATOR ','
  ) 'roles',
  GROUP_CONCAT(
    DISTINCT institutions.name
    ORDER BY institutions.name
    SEPARATOR ','
  ) 'institutions'
FROM
  authors,
  (
    SELECT
      author_id,
      ar,
      GROUP_CONCAT(
        DISTINCT CONCAT(ar,'.',wg)
        ORDER BY wg
        SEPARATOR ','
      ) 'working_groups',
      GROUP_CONCAT(
        DISTINCT CONCAT(ar,'.',wg,'.',chapter)
        ORDER BY wg, chapter
        SEPARATOR ','
      ) 'chapters',
      GROUP_CONCAT(
        DISTINCT CONCAT(ar,'.',wg,'.',chapter,'.',role)
        ORDER BY wg, chapter, role
        SEPARATOR ','
      ) 'roles',
      institution_id
    FROM participations
    GROUP BY author_id, ar
  ) AS participations,
  (
    SELECT
      id,
      CONCAT('"',name,'"') 'name'
    FROM institutions
  ) AS institutions
WHERE
  authors.id = participations.author_id
  AND institutions.id = participations.institution_id
GROUP BY authors.id
;
