import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["openingHours"];

  connect() {
    console.log("connected");
  }

  change(e) {
    let branch_office_id = e.target.value;
    fetch(`/branch_offices/opening_hours?branch_office=${branch_office_id}`, {
      headers: { accept: "application/json" },
    })
      .then((response) => response.json())
      .then((data) => {
        var openingHoursHTML = `
          <ul class="list-group list-group-horizontal ">
            <li class="list-group-item w-25 fw-bolder">Dia</li>
            <li class="list-group-item w-25 fw-bolder">Abre</li>
            <li class="list-group-item w-25 fw-bolder">Cierra</li>
          </ul>
        `;
        data.forEach((hour) => {
          openingHoursHTML += this.openingHourTemplate(hour);
        });
        console.log(openingHoursHTML);
        this.openingHoursTarget.innerHTML = openingHoursHTML;
      });
  }

  openingHourTemplate(hour) {
    return `
      <ul class="list-group list-group-horizontal ">
        <li class="list-group-item w-25">${hour.name} </li>
        <li class="list-group-item w-25">${hour.opens}</li>
        <li class="list-group-item w-25">${hour.closes}</li>
      </ul>
    `;
  }
}
