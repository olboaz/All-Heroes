import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Search by name :", "Batman", "Superman", "Abomination", "Hela"],
    attr: "placeholder",
    typeSpeed: 100,
    loop: true,

  });
}

export { loadDynamicBannerText };
