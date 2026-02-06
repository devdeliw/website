const images = {
  "01": "images/01.png",
  "02": "images/02.jpg",
  "03": "images/03.jpg",
  "04": "images/04.JPG",
  "05": "images/05.jpg",
  "06": "images/06.png",
  "07": "images/07.png",
  "08": "images/08.png",
  "09": "images/09.JPG",
  "10": "images/10.JPG",
  "11": "images/11.png",
  "12": "images/12.png",
  "13": "images/13.JPG",
  "14": "images/14.PNG",
  "15": "images/15.jpg",
};

const spreads = [
  {
    left: "01",
    right: "02",
    text:
      "LOOK AT US IN HIGHSCHOOL. And omg you are so adorable sleeping you look so beautiful.",
    tilt: "-2deg",
  },
  {
    left: "03",
    right: "04",
    text:
      "HOW ARE YOU SO FINE omg AND THE RED HAIR ANNIKA so pretty idk why u chose to date me.",
    tilt: "3deg",
  },
  {
    left: "05",
    right: "06",
    text: "LOOK AT YOU YOU ARE SO ADORABLE BLUEEEE",
    tilt: "-4deg",
  },
  {
    left: "07",
    right: "08",
    text: "You are absolutely stunning and PEPPERDINE TRIP",
    tilt: "2deg",
  },
  {
    left: "09",
    right: "10",
    text: "WITH DA HOMIE we were so funny together",
    tilt: "-3deg",
  },
  {
    left: "11",
    right: "12",
    text: "",
    tilt: "0deg",
  },
];

const singles = [
  {
    id: "13",
    text: "Now. I have a question to ask you... (its definitely not about valentines)",
    tilt: "-2deg",
    button: "Next",
  },
  {
    id: "14",
    text: "Will you be my valentine? (No isn't even an option .. you *HAVE* to choose YES)",
    tilt: "3deg",
    button: "YES",
  },
  {
    id: "15",
    text: "YAY (p.s. you have a present coming soon).",
    tilt: "-1deg",
    button: "Return",
  },
];

const cover = document.getElementById("cover");
const book = document.getElementById("book");
const leftPage = document.getElementById("left-page");
const rightPage = document.getElementById("right-page");
const imgLeft = document.getElementById("img-left");
const imgRight = document.getElementById("img-right");
const caption = document.getElementById("caption");
const action = document.getElementById("action");

const single = document.getElementById("single");
const imgSingle = document.getElementById("img-single");
const singleCaption = document.getElementById("single-caption");
const singleAction = document.getElementById("single-action");
const hearts = document.getElementById("hearts");

let spreadIndex = 0;
let singleIndex = 0;
let flipping = false;

function setCaption(text, tilt) {
  caption.textContent = text;
  caption.style.setProperty("--tilt", tilt || "0deg");
}

function setSingleCaption(text, tilt) {
  singleCaption.textContent = text;
  singleCaption.style.setProperty("--tilt", tilt || "0deg");
}

function renderSpread() {
  const spread = spreads[spreadIndex];
  imgLeft.src = images[spread.left];
  imgRight.src = images[spread.right];

  if (spread.text) {
    caption.classList.remove("hidden");
    setCaption(spread.text, spread.tilt);
  } else {
    caption.classList.add("hidden");
  }

  action.innerHTML = "";

  if (spreadIndex === spreads.length - 1) {
    const btn = document.createElement("button");
    btn.textContent = "You should click this button";
    btn.classList.add("big-click");
    btn.addEventListener("click", () => showSingle(0));
    action.appendChild(btn);
  }
}

function flipForward() {
  if (flipping) return;
  if (spreadIndex >= spreads.length - 1) return;
  flipping = true;
  book.classList.add("flipping");
  book.classList.remove("flipping-back");

  setTimeout(() => {
    spreadIndex += 1;
    renderSpread();
    book.classList.remove("flipping");
    flipping = false;
  }, 450);
}

function flipBackward() {
  if (flipping) return;
  if (spreadIndex <= 0) return;
  flipping = true;
  book.classList.add("flipping-back");
  book.classList.remove("flipping");

  setTimeout(() => {
    spreadIndex -= 1;
    renderSpread();
    book.classList.remove("flipping-back");
    flipping = false;
  }, 450);
}

function showBook() {
  cover.classList.add("hidden");
  single.classList.add("hidden");
  single.classList.remove("show");
  singleCaption.classList.add("hidden");
  singleAction.classList.add("hidden");
  hearts.classList.add("hidden");
  book.classList.remove("hidden");
  requestAnimationFrame(() => book.classList.add("opened"));
  caption.classList.remove("hidden");
  action.classList.remove("hidden");
  spreadIndex = 0;
  renderSpread();
}

function showSingle(index) {
  book.classList.add("hidden");
  book.classList.remove("opened");
  caption.classList.add("hidden");
  action.classList.add("hidden");
  single.classList.remove("hidden");
  requestAnimationFrame(() => single.classList.add("show"));
  singleCaption.classList.remove("hidden");
  singleAction.classList.remove("hidden");

  singleIndex = index;
  const stage = singles[singleIndex];
  imgSingle.src = images[stage.id];
  setSingleCaption(stage.text, stage.tilt);

  singleAction.innerHTML = "";
  const btn = document.createElement("button");
  btn.textContent = stage.button;
  if (stage.id === "14") {
    btn.classList.add("big-yes");
  }
  if (stage.id === "15") {
    btn.classList.add("wonky-return");
  }
  btn.addEventListener("click", () => handleSingleAdvance());
  singleAction.appendChild(btn);

  if (stage.id === "14" || stage.id === "15") {
    buildHearts();
    hearts.classList.remove("hidden");
  } else {
    hearts.classList.add("hidden");
  }
}

function handleSingleAdvance() {
  if (singleIndex === 0) {
    showSingle(1);
    return;
  }
  if (singleIndex === 1) {
    showSingle(2);
    return;
  }
  if (singleIndex === 2) {
    resetAll();
  }
}

function resetAll() {
  spreadIndex = 0;
  singleIndex = 0;
  book.classList.add("hidden");
  book.classList.remove("opened");
  caption.classList.add("hidden");
  action.classList.add("hidden");
  single.classList.add("hidden");
  single.classList.remove("show");
  singleCaption.classList.add("hidden");
  singleAction.classList.add("hidden");
  hearts.classList.add("hidden");
  cover.classList.remove("hidden");
}

function buildHearts() {
  if (hearts.children.length > 0) return;
  for (let i = 0; i < 32; i += 1) {
    const heart = document.createElement("span");
    heart.className = "heart";
    const size = 10 + Math.random() * 22;
    heart.style.width = `${size}px`;
    heart.style.height = `${size}px`;
    heart.style.left = `${Math.random() * 100}%`;
    heart.style.top = `${Math.random() * 100}%`;
    heart.style.animationDelay = `${Math.random() * 1.5}s`;
    heart.style.animationDuration = `${1.8 + Math.random() * 2.2}s`;
    heart.style.opacity = `${0.45 + Math.random() * 0.35}`;
    hearts.appendChild(heart);
  }
}

cover.addEventListener("click", showBook);
rightPage.addEventListener("click", flipForward);
rightPage.addEventListener("keydown", (event) => {
  if (event.key === "Enter" || event.key === " ") {
    event.preventDefault();
    flipForward();
  }
});

leftPage.addEventListener("click", flipBackward);
leftPage.addEventListener("keydown", (event) => {
  if (event.key === "Enter" || event.key === " ") {
    event.preventDefault();
    flipBackward();
  }
});
