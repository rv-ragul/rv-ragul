#set text(size: 13pt)
#set page(margin: (x: 1.5cm, y: 1.5cm) )

/// Custom link
#let custom_link(dest, desc)={
  link(dest, underline(text(fill:blue,desc)))
}

/// Some useful functions
#let page_header(header) = {
  let name = header.at("name", default: "Name_of_the_person")
  let mail = header.at("mail", default: "mail_id@mail.com")
  let contact = header.at("contact", default: "+12 9876543210")
  let address = header.at("address", default: "address_of_the_person")
  let github = header.at("github", default: "github.com/username")
  let gitlab = header.at("gitlab", default: "gitlab.com/username")

  let separator = sym.diamond.stroked

  align(center, heading(name))
  block(spacing:0.3cm, width:100%, align(center, [#contact #separator #address]))
  block(spacing:0.3cm, width:100%, align(center,[#underline(text(fill:blue, link("mailto:"+mail))) #separator #custom_link(github)[#github] #separator #custom_link(gitlab)[#gitlab]]))
  
}

#let achievement(achievement) = {
  let title = achievement.at("title", default: "")
  let year = achievement.at("year", default: "")
  let points = achievement.at("points", default: "")

  grid(
    columns: (2fr, 1fr),
    heading(level: 3, title),
    align(right, year)
  )
  if type(points) == array {
    for point in points{
      list(point)
    }
  } else {
    list(points)
  }
}

#let project(project) = {
  let desc = project.at("desc", default: "")
  let tech = project.at("tech", default: "")
  let project_link = project.at("link", default: "")

  heading(level: 3)[
    #project.name
    #if project_link != "" [
      ( #custom_link(project_link)[#project_link] )
    ]
  ]
  list(text(desc) + linebreak())
  list({
    underline(emph(text(weight: "semibold", "Tech Stack:"))) + text(" ")
    tech.split(",").map(tech => tech.trim()).join(", ", last: " and ")
  })
}

#let conference(conference) = {
  let title = conference.at("title", default: "")
  let _link = conference.at("link", default: "")
  let event = conference.at("event", default: "")
  let desc = conference.at("desc", default: "")

  grid(
    columns: (5fr, 1fr),
    heading(level: 3, custom_link(_link, text(size: 12pt, title))),
    align(right, event)
  )
  desc
}

#let experience(experience) = {
  let role = experience.at("role", default: "")
  let org = experience.at("org", default: "")
  let period = experience.at("period", default: "")
  let points = experience.at("points", default: "")

  block(
    below: 0.3cm,
    grid(
      columns: (2fr,1fr),
      heading(level: 2, role),
      align(right, period)
    )
  )
  block(below:0.2cm, org)
  block()

  if type(points) == array {
    for point in points{
      list(point)
    }
  } else {
    list(points)
  }
}

#let education(education) = {
  let level = education.at("level", default: "")
  let institute = education.at("institute", default: "")
  let completion_year = education.at("completion_year", default: "")
  let cgpa = education.at("cgpa", default: "")

  block(
    below: 0.3cm,
    grid(
      columns: (2fr, 1fr),
      heading(level: 3, level),
      align(right, completion_year)
    )
  )
  [#institute #h(1fr) CGPA - #cgpa]
}

#let skills(..skills)={
  skills.pos().map(skill => {
    grid(
      columns: (1fr, 2fr),
      text(weight: "semibold", skill.title) + " ",
      text(skill.skills.join(", ", last: " and ")),
    )
  })
}.join()

#let section(title, ..content) = {
  heading(level: 2, upper(title))
  line(length: 100%)
  content.pos().join()
}
/// functions end here

// Page header
#page_header(
  (
    name:"RAGUL R",
    contact: "+91 6374554600",
    mail: "ragul542rv@gmail.com",
    address: "Perambalur, Tamil Nadu, India",
    github: "https://github.com/rv-ragul",
    gitlab: "https://gitlab.com/rv-ragul"
  )
)

// Achievements
#section(
  "ACHIEVEMENTS",
  achievement(
    (
      title: "First Prize in Safetython",
      year: "2023",
      points: (
        "Conducted by Uyir Foundation in collaboration with Tamil Nadu Police",
        "Proposed the idea of an AI powered Dynamic traffic regulatory system",
        "Honoured by Commissioner of Police, Coimbatore with cash prize of INR 12,000",
      ),
    ),
  ),
  // achievement(
  //   (
  //     title: "First Prize in Ideathon",
  //     year: "2023",
  //     points: (
  //       "Conducted by KPR college of Technology, Coimbatore",
  //       "Proposed a black box based solution for the routing of emergency vehicle",
  //     ),
  //   ),
  // ),
  achievement(
    (
      title: "Certificate for the development of DLAPP",
      year: "2022",
      points: ("Honoured by Dean of AURCC for developing DLAPP for Android and Web"),
    ),
  ),
)

// Projects
#section(
  "PROJECTS",
  project(
    (
      name: "API Server",
      desc: "An API server for all the services running in our university domain.",
      tech: ("Python, FastAPI, Keycloak, Python, PostgreSQL, SQLAlchemy"),
      link: "https://api.aurcc.in",
    ),
  ),
  project((
    name: "DAMS",
    desc: "A web app for student attendance managment system.",
    tech: "Keycloak, podman, Vue.js",
    link: "https://dams.aurcc.in",
  )),
  project(
    (
      name: "AUSMART",
      desc: "A web app for college students to give suggestions to the Dean of college securely.",
      tech: "Keycloak, podman, Vue.js, Telegram Bot API",
      link: "https://ausmart.aurcc.in",
    ),
  ),
  project(
    (
      name: "INFORMATION KIOSK",
      desc: "A web app to show important news and announcements to college students.",
      tech: "Python, GTK, Webkit, HTML, Next Cloud",
    ),
  ),
  project(
    (
      name: "DLAPP",
      desc: "An Android and a web app to request permission from HOD & Dean of AURCC.",
      tech: "Kotlin, Nuxt, tailwind css, daisyUI, Firebase Realtime Database and FCM",
      link: "https://dlapp.aurcc.in",
    ),
  ),
)

// Conferences
#section("CONFERENCES",
  conference(
    (
      title: "State of Stateless - A Talk about Immutability and Reproducibility in Debian",
      desc: "Presented a talk on DebConf23 about Immutability, Reproducibility in Debian.",
      link: "https://debconf23.debconf.org/talks/41-state-of-stateless-a-talk-about-immutability-and-reproducibility-in-debian/",
      event: "DebConf 2023"
    )
  )
)

#pagebreak()

// Experience
#section("EXPERIENCE",
  experience(
    (
      role: "DevOps",
      org: "Anna University Regional Campus, Coimbatore",
      period: "2021 - 2023",
      points: (
        "Maintaining one of the college servers for the DGATE cell",
        "Developed and deployed above mentioned services in the backend server"
      )
    )
  ),
  experience(
    (
      role: "Secretary of Tamil Mandram",
      org: "Anna University Regional Campus, Coimbatore",
      period: "Semester 6, 7",
      points: (
        [Conducted various competetions for Independence day #h(1fr) 2023],
        [Organized an event called தமிழ் 4.0 to create awareness about FOSS #h(1fr) 2023]
      )
    )
  )
)

// Education
#section("EDUCATION",
  education(
    (
      level: "Bachelor of Engineering",
      institute: "Anna University Regional Campus, Coimbatore",
      completion_year: "Expected 2024",
      cgpa: 8.67
    )
  ),
  education(
    (
      level: "High School",
      institute: "SRM Muthamizhl Higher Secondary School, Salem",
      completion_year: "2020",
      cgpa: 9.03
    )
  ),
  education(
    (
      level: "Secondary School",
      institute: "Bharathi Vidhya Mandir Matriculation School, Salem",
      completion_year: "2018",
      cgpa: 9.76
    )
  )
)

// Skills
#section(
  "SKILLS",
  skills(
    (title: "Programming languages", skills: (
      "C",
      "Rust",
      "Python",
      "Javascript",
      "PHP",
      "Java",
      "Kotlin",
      "Lua",
    )),
    (
      title: "Tools",
      skills: ("Git", "docker", "podman", "keycloak", "meson"),
    ),
    (title: "Frameworks", skills: ("FastAPI", "NuxtJs", "VueJs", "Flask")),
    (
      title: "Databases",
      skills: ("PostgreSQL", "MySQL", "Mongodb", "Redis", "Firebase"),
    ),
    (title: "Soft skills", skills: (
      "Communication skills",
      "Leadership quality(coordinator of Tamil Mandram)",
      "Creativity",
      "Critical thinking",
    )),
  ),
)
