require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("turbolinks").start()

import "bootstrap";
import $ from 'jquery';

import { initMapbox } from '../plugins/init_mapbox.js';
import { loadDynamicBannerText } from '../components/banner';

document.addEventListener('turbolinks:load', () => {
  initMapbox();
  loadDynamicBannerText();
})
