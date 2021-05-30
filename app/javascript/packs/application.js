// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// require("trix")
// require("@rails/actiontext")

import $ from 'jquery'
import axios from 'axios'

const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

window.addEventListener('load', () => {
    const uploader = document.querySelector('.form-avatar');
    $(uploader).on('change', (e) => {
        const file = uploader.files[0];
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = () => {
            const image = reader.result;
            document.querySelector('.avatar').setAttribute('src', image);
        }
        $('.form-btn').trigger('click');
        }
    );
});

document.addEventListener('turbolinks:load', () => {

    const dataset = $('.timeline_funcsion').attr('id')
    const timelineId = dataset
    axios.get(`/api/timelines/${timelineId}/like`)
        .then((response) => {
            const hasLiked = response.hasLiked
            if (hasLiked) {
                $('.active-heart').removeClass('hidden')
            } else {
                $('.inactive-heart').removeClass('hidden')
            }
        })
})
