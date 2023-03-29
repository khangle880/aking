var timmer_stringeedx = setTimeout(function() {
	var bodyDx = document.querySelector("body");
	if(bodyDx) {
		load();
		clearTimeout(timmer_stringeedx);
	}
}, 10);


function load () {
	console.log("++ I am StringeeXChat Embeded Script");

	var x = document.getElementsByTagName('head')[0];
	var style = document.createElement('style');
		style.type = 'text/css';
		style.innerHTML = '.stringeeX_chatbox_iframe_wrapper.full-open{border-radius: 10px;width: 380px;height: 580px;margin-bottom: 0;margin-right: 0;box-shadow: rgba(0, 0, 0, 0.16) 0px 5px 40px}.stringeeX_chatbox_iframe_wrapper{margin-top: 0;margin-right: 0;margin-bottom: 0;padding: 0;display: block;background: transparent;position: fixed !important;z-index: 99999;width: 56px;height: 56px;box-sizing: content-box}.stringeeX_chatbox_iframe_wrapper .iframe{background-color: transparent;vertical-align: text-bottom;position: relative;width: 100%;height: 100%;min-width: 100%;min-height: 100%;max-width: 100%;max-height: 100%;margin: 0;overflow: hidden;display: block;border-width: 0}.drop-down-rectangle1{position: absolute;width: 15px;height: 15px;background: #FFF;transform: rotate(45deg);top: -5px;right: 35px;border: 1px solid #E9EBED}.stringeeX_chatbox_iframe_wrapper.full-open .header{height: 40px;width: calc(100% - 70px);position: absolute;z-index: 1000;cursor: move}@media only screen and (min-device-width: 280px) and (max-device-width: 1024px) and (orientation: portrait){.stringeeX_chatbox_iframe_wrapper.full-open{width: 100%;height: 100%;margin-bottom: 0;margin-right: 0}.stringeeX_chatbox_iframe_wrapper{width: 56px;height: 56px;right: 0 !important;bottom: 0 !important}}@media only screen and (min-device-width: 280px) and (max-device-width: 1024px)  and (orientation: portrait){.stringeeX_chatbox_iframe_wrapper.full-open{width: 100%;height: 100%;margin-bottom: 0;margin-right: 0}.stringeeX_chatbox_iframe_wrapper{width: 56px;height: 56px;right: 0 !important;bottom: 0 !important}}@media only screen and (min-device-width: 280px) and (max-device-width: 1024px)  and (orientation: landscape){.stringeeX_chatbox_iframe_wrapper.full-open{width: 100%;height: 100%;margin-bottom: 0;margin-right: 0}.stringeeX_chatbox_iframe_wrapper{width: 56px;height: 56px;right: 0 !important;bottom: 0 !important}}@media only screen and (min-device-width: 280px) and (max-device-width: 1024px) and (orientation: landscape){.stringeeX_chatbox_iframe_wrapper.full-open{width: 100%;height: 100%;margin-bottom: 0;margin-right: 0}.stringeeX_chatbox_iframe_wrapper{width: 56px;height: 56px;right: 0 !important;bottom: 0 !important}}';
		x.appendChild(style);

	getContentIframe = function (iframe_html) {
		var div = document.createElement("div");
			div.setAttribute('class', 'stringeeX_chatbox_iframe_wrapper product');
			div.setAttribute('id', 'stringeeX_chatbox_iframe_wrapper');
			div.style.display = 'none';
		var header = document.createElement('div');
		header.setAttribute('class', 'header');
			div.appendChild(header);
		var iframe = document.createElement('iframe');
			iframe.setAttribute('class', 'iframe');
			iframe.setAttribute('id', 'stringeeChatIframe');
			div.appendChild(iframe);
			document.body.appendChild(div);
			iframe.contentWindow.document.open();
			iframe.contentWindow.document.write(iframe_html);
			iframe.contentWindow.document.close();
	};

	var iframe_html = '<!DOCTYPE html><html><head>	<title>STRINGEEX CHAT BOX</title>	<meta charset="UTF-8">	<meta name="viewport" content="width=device-width, initial-scale=1.0">	<link rel="stylesheet" type="text/css" href="https://v2.stringee.com/stringeexchat/sdk/product/css/stringeeChatSDK-2.0.2.css" />	<script type="text/javascript" src="https://v2.stringee.com/stringeexchat/sdk/product/js/stringeeChatSDK-2.0.2.js"></script></head><body>	<div class="container">		<div class="row">			<div id="stringeechat">				<div class="Layout Layout-open Layout-expand Layout-right stringeechat">					<div class="Messenger_messenger initial_form">						<div class="Messenger_header">							<h4 class="Messenger_prompt" tkey="leave_message">Leave us a message</h4>							<div class="header_right">								<span class="chat_close_icon init">									<svg>										<path d="M0 0H30V5H0z"></path>									</svg>								</span>							</div>						</div>						<div class="wrapper">							<div class="inner">								<div class="user_form">									<div class="out-opearting-hour" tkey="out_business_hour"></div>									<form novalidate>										<div class="form-group inputName">											<label for="inputName" tkey="your_name">Your name</label>											<input type="text" class="required form-control form-control-sm" id="inputName" tpla="your_name" placeholder="Your name">											<div class="invalid-feedback"> Name is required</div>										</div>										<div class="form-group inputPhone">											<label for="inputPhone" tkey="phone_number">Phone number</label>											<input type="tel" class="required form-control form-control-sm" name="phone" id="inputPhone" />											<div class="invalid-feedback" id="invalid-phone-number-text">												<span tkey="invalid_phone_number">Invalid phone number</span>											</div>										</div>										<div class="form-group inputEmail">											<label for="inputEmail" tkey="email_address">Email address</label>											<input type="email" class="required form-control form-control-sm" id="inputEmail" placeholder="your@email.com">											<div class="invalid-feedback" id="invalid-email-text">												<span tkey="invalid_email_address">Invalid email address</span>											</div>										</div>										<div class="form-group select_queue">											<label for="exampleFormControlSelect1" tkey="select_queue">Select queue</label>											<select class="form-control form-control-sm" id="select_queue">											</select>										</div>										<div class="custom-field-box"></div>										<div class="form-group inputInfo">											<label for="inputInfo" tkey="first_msg">How can we help you?</label>											<textarea tpla="pl_first_msg" placeholder="Type a message here.." class="required message_field form-control" id="inputInfo" rows="4"></textarea>										</div>									</form>								</div>								<div class="form_actions">									<div class="top">										<input type="file" id="file" style="display:none;" />										<button type="button" class="btn btn-sm btn-light" id="btn_cancel_form" tkey="btn_cancel">											Cancel										</button>										<button type="button" class="btn btn-light btn-sm toggle-disabled" disabled id="btn_submit_form" tkey="btn_submit">											Submit										</button>									</div>									<div class="bottom stringeex"><a target="_blank" href="https://stringeex.com/">StringeeX</a></div>								</div>							</div>							<div class="inner-business-hour">								<div class="sc-dnqmqq fmIRHN">									<div class="sc-iwsKbI fcOiXF">										<svg viewBox="0 0 163 81.09">											<title></title>											<defs>												<style>													.custom-cls-1 {														fill: #ccc													}													.cls-2 {														fill: #cccccb													}													.cls-3 {														fill: #f8f8f8													}													.cls-4 {														fill: none													}												</style>											</defs>											<g id="Layer_2" data-name="Layer 2">												<g id="Layer_1-2" data-name="Layer 1">													<path class="custom-cls-1" d="M35.5 5.26A2.5 2.5 0 1138 2.76 2.5 2.5 0 0135.5 5.26zm0-4A1.5 1.5 0 1037 2.76 1.5 1.5 0 0035.5 1.26zM138.49 32.76a3 3 0 113-3A3 3 0 01138.49 32.76zm0-5a2 2 0 102 2A2 2 0 00138.49 27.76z"></path>													<path class="cls-2" d="M159 39.76h-1.5v-1.5a1 1 0 10-2 0v1.5H154a1 1 0 000 2h1.5v1.5a1 1 0 002 0v-1.5H159a1 1 0 000-2zM132.49 6.76h-3v-3a1 1 0 00-2 0v3h-3a1 1 0 000 2h3v3a1 1 0 102 0v-3h3a1 1 0 000-2zM31.5 26.76h-3v-3a1 1 0 00-2 0v3h-3a1 1 0 000 2h3v3a1 1 0 102 0v-3h3a1 1 0 000-2z"></path>													<circle class="custom-cls-1" cx="161.5" cy="18.66" r="1.5"></circle>													<circle class="custom-cls-1" cx="1.5" cy="17.76" r="1.5"></circle>													<circle class="custom-cls-1" cx="11.5" cy="45.76" r="2"></circle>													<path class="cls-3" d="M126.07,71.09h-6v.1a5,5,0,0,1-5,5H53a5,5,0,0,1-5-5v-.1h-7a5,5,0,1,0,0,10h85a5,5,0,0,0,0-10Z"></path>													<path class="cls-4" d="M52.73 29.19L52.29 29.59 53.02 30.27 53.02 28.92 52.99 28.95 52.99 29.44 52.73 29.19z"></path>													<path class="cls-4" d="M52.99 29.44L52.99 28.95 52.73 29.19 52.99 29.44zM71 59.62l1.46-1 4.83-3.32L55 34.82l-1-.92L53 33l-2.21-2A3.78 3.78 0 0050 33.19v37.9h4.32L69.59 60.62zM92.62 8.62h0L86.47 3A3.68 3.68 0 0084 2h0a3.68 3.68 0 012.43 1z"></path>													<path class="cls-4" d="M75.39 8.62H92.62L86.44 3A3.68 3.68 0 0084 2a3.65 3.65 0 00-2.43 1zM115.02 30.3L115.02 30.32 115.77 29.63 115.02 28.94 115.02 28.97 115.74 29.63 115.02 30.3z"></path>													<path class="cls-4" d="M115.74 29.63L115.02 28.97 115.02 30.3 115.74 29.63zM80.55 53.08a6.26 6.26 0 017 0l1.53 1.06 23.94-22V11.62a1 1 0 00-1-1H56a1 1 0 00-1 1h0a1 1 0 011-1h0a1 1 0 00-1 1v12.8h0v1.35h0V32.1l24 22zM71.77 29.45a1.13 1.13 0 011.63.12l7.33 8.28L97.37 20.12A1.15 1.15 0 0199 21.75L81.54 40.42a1.05 1.05 0 01-.81.35 1.33 1.33 0 01-.93-.35l-8.15-9.33A1.14 1.14 0 0171.77 29.45zM117.26 31L115 33 114 34l-1 .92L90.78 55.3l4.83 3.32 1.45 1 1.46 1 15.24 10.47H118V33.19A3.78 3.78 0 00117.26 31z"></path>													<path class="cls-4" d="M93.53,59.62l-1.46-1-5.65-3.89A4.31,4.31,0,0,0,84,54a4.23,4.23,0,0,0-2.35.72L76,58.62l-1.46,1-1.45,1L57.87,71.09h52.36L95,60.62Z"></path>													<path class="cls-2" d="M117.7,28.68,115,26.24V11.62a3,3,0,0,0-3-3H95.62l-7.81-7.1A5.72,5.72,0,0,0,84.05,0H84a5.72,5.72,0,0,0-3.76,1.52l-7.81,7.1H56a3,3,0,0,0-3,3V26.24l-2.68,2.44A5.55,5.55,0,0,0,48,33.19v38a5,5,0,0,0,5,5h62a5,5,0,0,0,5-5v-38A5.56,5.56,0,0,0,117.7,28.68Zm-2.71.26,0,0v0l.75.69-.75.69v0l0,0ZM81.54,3A3.68,3.68,0,0,1,84,2h0a3.68,3.68,0,0,1,2.45,1l6.18,5.62H75.36ZM55,27.1V25.77h0V24.42h0V11.62h0a1,1,0,0,1,1-1h56a1,1,0,0,1,1,1V32.16l-23.94,22-1.53-1.06a6.26,6.26,0,0,0-7,0L79,54.14l-24-22Zm-2,1V29l0,0v1.35l-.73-.68.43-.4-.46-.43Zm-2,45.3a3,3,0,0,1-1-2.2v-38A3.78,3.78,0,0,1,50.81,31L53,33l1,.92,1,.92L77.33,55.3,72.5,58.62l-1.46,1-1.45,1L54.34,71.09Zm2.37.8,4.5-3.1L73.12,60.62l1.45-1,1.46-1,5.66-3.89A4.23,4.23,0,0,1,84,54a4.31,4.31,0,0,1,2.38.72l5.65,3.89,1.46,1,1.46,1,15.24,10.47,4.5,3.1Zm64.65-3a3,3,0,0,1-1,2.17l-3.31-2.27L98.52,60.62l-1.46-1-1.45-1L90.78,55.3,113,34.88l1-.92,1-.92L117.26,31a3.78,3.78,0,0,1,.76,2.21v38Z"></path>													<path class="cls-2" d="M52.99 28.95L52.99 28.09 52.26 28.76 52.73 29.19 52.99 28.95zM115.02 28.97L114.99 28.94 114.99 30.32 115.02 30.3 115.02 28.97zM92.62 8.62H75.39L81.58 3A3.65 3.65 0 0184 2h0a3.68 3.68 0 00-2.45 1L75.36 8.62z"></path>													<path class="cls-5 customColor" d="M80.73,40.77a1.05,1.05,0,0,0,.81-.35L99,21.75a1.15,1.15,0,0,0-1.63-1.63L80.73,37.85,73.4,29.57a1.16,1.16,0,1,0-1.75,1.52l8.15,9.33A1.33,1.33,0,0,0,80.73,40.77Z"></path>												</g>											</g>										</svg>									</div>									<div>										<h2 class="reaching-out" tkey="reaching_out"></h2>										<p class="contact-someone" tkey="contact_someone"></p>									</div>									<div>										<a href="#" class="go-back-intial-form" tkey="go_back"></a>									</div>								</div>							</div>							<div class="setup_chatprofile">								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -96 512.001 512" width=" 50px">									<path d="m471.5 91.558594h-96.667969c-4.140625 0-7.5 3.355468-7.5 7.5 0 4.144531 3.359375 7.5 7.5 7.5h96.667969c4.144531 0 7.5-3.355469 7.5-7.5 0-4.144532-3.355469-7.5-7.5-7.5zm0 0" />									<path d="m471.5 126.890625h-47.097656c-4.144532 0-7.5 3.359375-7.5 7.5 0 4.144531 3.355468 7.5 7.5 7.5h47.097656c4.144531 0 7.5-3.355469 7.5-7.5 0-4.140625-3.355469-7.5-7.5-7.5zm0 0" />									<path d="m389.507812 126.890625h-14.675781c-4.140625 0-7.5 3.359375-7.5 7.5 0 4.144531 3.359375 7.5 7.5 7.5h14.675781c4.140626 0 7.5-3.355469 7.5-7.5 0-4.140625-3.359374-7.5-7.5-7.5zm0 0" />									<path d="m233.871094 169.578125c17.617187 0 31.953125-14.332031 31.953125-31.953125 0-17.617188-14.335938-31.949219-31.953125-31.949219-17.617188 0-31.949219 14.332031-31.949219 31.949219 0 17.621094 14.332031 31.953125 31.949219 31.953125zm0-48.902344c9.347656 0 16.953125 7.601563 16.953125 16.949219s-7.605469 16.953125-16.953125 16.953125-16.949219-7.605469-16.949219-16.953125c0-9.34375 7.601563-16.949219 16.949219-16.949219zm0 0" />									<path d="m173.210938 157.808594h3.367187c.726563 2.058594 1.566406 4.089844 2.511719 6.0625l-2.382813 2.378906c-2.558593 2.558594-3.96875 5.960938-3.96875 9.578125 0 3.621094 1.410157 7.019531 3.96875 9.578125l9.386719 9.386719c5.28125 5.277343 13.875 5.277343 19.152344 0l2.382812-2.382813c1.972656.941406 4.003906 1.785156 6.0625 2.511719v3.367187c0 7.46875 6.078125 13.542969 13.546875 13.542969h13.269531c7.46875 0 13.546876-6.074219 13.546876-13.542969v-3.367187c2.058593-.726563 4.089843-1.570313 6.058593-2.511719l2.382813 2.382813c5.28125 5.277343 13.875 5.277343 19.15625 0l9.386718-9.386719c5.277344-5.28125 5.277344-13.871094-.003906-19.15625l-2.378906-2.378906c.941406-1.972656 1.785156-4.003906 2.507812-6.0625h3.371094c7.46875 0 13.542969-6.078125 13.542969-13.546875v-13.269531c0-7.46875-6.074219-13.546876-13.542969-13.546876h-3.371094c-.722656-2.0625-1.566406-4.09375-2.507812-6.0625l2.382812-2.382812c5.277344-5.28125 5.277344-13.875 0-19.152344l-9.386718-9.386718c-5.285156-5.28125-13.875-5.277344-19.15625 0l-2.382813 2.382812c-1.96875-.941406-4-1.785156-6.058593-2.511719v-3.367187c0-7.46875-6.078126-13.546875-13.546876-13.546875h-13.269531c-7.46875 0-13.546875 6.078125-13.546875 13.546875v3.367187c-2.058594.726563-4.089844 1.566407-6.0625 2.511719l-2.382812-2.382812c-5.277344-5.277344-13.871094-5.277344-19.152344 0l-9.382812 9.382812c-2.5625 2.5625-3.972657 5.960938-3.972657 9.582031 0 3.617188 1.410157 7.019531 3.96875 9.578125l2.382813 2.378906c-.945313 1.972657-1.785156 4.003907-2.511719 6.0625h-3.367187c-7.46875 0-13.546876 6.078126-13.546876 13.546876v13.269531c0 7.46875 6.078126 13.546875 13.546876 13.546875zm1.453124-25.363282h2.957032c5.839844 0 11.007812-3.734374 12.859375-9.292968.675781-2.035156 1.507812-4.042969 2.46875-5.96875 2.625-5.242188 1.613281-11.539063-2.515625-15.667969l-2.089844-2.089844 7.324219-7.328125 2.089843 2.089844c4.132813 4.128906 10.425782 5.140625 15.671876 2.519531 1.921874-.960937 3.929687-1.792969 5.96875-2.472656 5.558593-1.851563 9.292968-7.019531 9.292968-12.855469v-2.957031h10.359375v2.957031c0 5.835938 3.734375 11.003906 9.292969 12.855469 2.039062.679687 4.046875 1.511719 5.972656 2.472656 5.246094 2.621094 11.539063 1.609375 15.667969-2.519531l2.089844-2.089844 7.328125 7.328125-2.09375 2.089844c-4.128906 4.128906-5.140625 10.425781-2.515625 15.667969.960937 1.921875 1.792969 3.929687 2.472656 5.96875 1.847656 5.558594 7.015625 9.292968 12.855469 9.292968h2.957031v10.363282h-2.957031c-5.839844 0-11.007813 3.734375-12.855469 9.289062-.679687 2.042969-1.511719 4.050782-2.472656 5.96875-2.625 5.246094-1.613281 11.542969 2.515625 15.671875l2.09375 2.089844-7.328125 7.328125-2.089844-2.089844c-4.128906-4.128906-10.425781-5.140625-15.671875-2.519531-1.921875.960937-3.929688 1.792969-5.96875 2.472656-5.558594 1.851563-9.292969 7.019531-9.292969 12.855469v2.957031h-10.359375v-2.957031c0-5.839844-3.734375-11.003906-9.292968-12.855469-2.039063-.679687-4.046876-1.511719-5.96875-2.472656-5.246094-2.625-11.542969-1.613281-15.671876 2.519531l-2.089843 2.089844-7.324219-7.328125 2.089844-2.089844c4.128906-4.128906 5.140625-10.425781 2.515625-15.667969-.960938-1.921874-1.792969-3.929687-2.46875-5.972656-1.851563-5.554687-7.019531-9.289062-12.859375-9.289062h-2.957032zm0 0" />									<path d="m487.441406 58.808594h-42.371094v-34.898438c0-13.183594-10.726562-23.910156-23.910156-23.910156h-374.578125c-13.183593 0-23.90625 10.726562-23.90625 23.910156v238.664063h-5.21875c-9.625 0-17.457031 7.832031-17.457031 17.457031 0 22.019531 17.914062 39.933594 39.933594 39.933594h387.957031c22.019531 0 39.933594-17.914063 39.933594-39.933594 0-9.625-7.832031-17.457031-17.457031-17.457031h-5.296876v-82.832031h42.375c13.539063 0 24.554688-11.015626 24.554688-24.554688v-71.820312c0-13.542969-11.015625-24.558594-24.558594-24.558594zm-449.765625-34.898438c0-4.914062 3.996094-8.910156 8.90625-8.910156h374.578125c4.914063 0 8.910156 3.996094 8.910156 8.910156v34.898438h-12.4375v-22.878906c0-5.476563-4.460937-9.9375-9.941406-9.9375h-347.640625c-5.480469 0-9.9375 4.460937-9.9375 9.9375v85.410156c0 4.140625 3.355469 7.5 7.5 7.5 4.140625 0 7.5-3.359375 7.5-7.5v-80.347656h337.519531v17.816406h-47.292968c-13.539063 0-24.554688 11.015625-24.554688 24.554687v71.820313c0 12.9375 10.050782 23.566406 22.753906 24.492187l-8.578124 29.742188c-1.078126 3.738281.367187 7.707031 3.597656 9.875 1.515625 1.015625 3.246094 1.523437 4.96875 1.523437 1.960937 0 3.910156-.648437 5.53125-1.933594l43.574218-34.492187v51.070313h-337.523437v-79.226563c0-4.144531-3.355469-7.5-7.5-7.5-4.140625 0-7.5 3.355469-7.5 7.5v84.289063c0 5.480468 4.460937 9.9375 9.941406 9.9375h347.640625c5.480469 0 9.941406-4.457032 9.941406-9.9375v-60.78125h12.4375v82.832031h-392.394531zm152.800781 281.050782c1.835938-4.183594 6.019532-7.113282 10.875-7.113282h65.121094c4.855469 0 9.039063 2.933594 10.878906 7.113282zm259.890626-27.386719c1.355468 0 2.457031 1.101562 2.457031 2.457031 0 13.746094-11.1875 24.933594-24.933594 24.933594h-134.964844c-2.253906-12.554688-13.257812-22.113282-26.453125-22.113282h-65.121094c-13.195312 0-24.199218 9.558594-26.449218 22.113282h-134.96875c-13.75-.003906-24.933594-11.1875-24.933594-24.933594 0-1.355469 1.101562-2.457031 2.457031-2.457031zm46.632812-122.386719c0 5.269531-4.285156 9.554688-9.558594 9.554688h-80.488281c-2.363281 0-4.683594.808593-6.535156 2.273437l-35.785157 28.324219 4.945313-17.148438c.925781-3.210937.304687-6.582031-1.703125-9.25-2.007812-2.667968-5.074219-4.199218-8.414062-4.199218h-4.121094c-5.269532 0-9.554688-4.285157-9.554688-9.558594v-71.816406c0-5.273438 4.285156-9.558594 9.554688-9.558594h132.105468c5.269532 0 9.554688 4.285156 9.554688 9.558594zm0 0" /></svg>								<!-- <img src="./public_html/assets/technical-support.svg" alt=""> -->								<p tkey="chat_settings"></p>							</div>						</div>					</div>					<div class="Messenger_messenger initial_chat">						<div class="Messenger_header">							<h4 class="Messenger_prompt" tkey="chat_us">Chat with us</h4>							<div class="header_right">								<span class="chat_iframe_icon">									<svg width="10" height="10" viewBox="0 0 10 10" xmlns="http://www.w3.org/2000/svg">										<g fill="none" fill-rule="evenodd">											<path d="M1.7325,9.47483 L7.8135,3.39383 L7.8135,6.64683 C7.8135,7.21183 8.2375,7.63683 8.8035,7.63683 C9.3685,7.63683 9.7935,7.21183 9.7935,6.64683 L9.7935,0.98983 C9.7935,0.84883 9.7935,0.70683 9.7225,0.63683 C9.5815,0.35383 9.4405,0.21183 9.1565,0.07083 C9.0155,0.07083 8.9445,-0.00017 8.8035,-0.00017 L3.1465,-0.00017 C2.8635,-0.00017 2.6515,0.07083 2.4395,0.28283 C2.2275,0.49483 2.1565,0.70683 2.1565,0.98983 C2.1565,1.55583 2.5815,1.97983 3.1465,1.97983 L6.3995,1.97983 L0.3175,8.06083 C-0.1055,8.48583 -0.1055,9.05083 0.3175,9.47483 C0.7425,9.89983 1.3085,9.89983 1.7325,9.47483" fill="#000" mask="url(#mask-2)"></path>										</g>									</svg>								</span>								<span class="chat_close_icon">									<svg>										<path d="M0 0H30V5H0z"></path>									</svg>								</span>							</div>						</div>						<div class="participate_list">							<ul id="participate_list">							</ul>							<div class="bottom">								<button class="returntochat" id="returntochat" tkey="back_chat">Back to Chat</button>								<p class="stringeex"><a target="_blank" href="https://stringeex.com/">StringeeX</a></p>							</div>						</div>						<div class="Messenger_content">							<div class="message_agents" id="message_agents">								<div class="left">									<div class="agent_avatar">										<img id="agent_avatar" src="" />									</div>									<div class="agent_name">										<p class="name" tkey="live_support">Live Support</p>										<p class="support" tkey="cus_support">Customer Support</p>									</div>								</div>								<div class="right">									<button type="button" class="btn_rate thumbsup" data-val="1">										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">											<g fill="none" stroke="currentColor">												<path stroke-linejoin="round" d="M14.5 6.5a1 1 0 0 1 1 1c-.1 2.4-.4 8-2 8H5a.47.47 0 0 1-.5-.5V6.9a.55.55 0 0 1 .3-.5c.6-.2 1.7-1 1.7-4.4a1.5 1.5 0 0 1 3 0v4.5z"></path>												<rect width="2" height="9" x=".5" y="6.5" rx=".5" ry=".5"></rect>											</g>										</svg>									</button>									<button type="button" class="btn_rate thumbsdown" data-val="0">										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">											<g fill="none" stroke="currentColor">												<path stroke-linejoin="round" d="M1.5 9.5a1 1 0 0 1-1-1c.1-2.4.4-8 2-8H11a.47.47 0 0 1 .5.5v8.1a.55.55 0 0 1-.3.5c-.6.2-1.7 1-1.7 4.4a1.5 1.5 0 0 1-3 0V9.5z"></path>												<rect width="2" height="9" x="13.5" y=".5" rx=".5" ry=".5"></rect>											</g>										</svg>									</button>								</div>							</div>							<div class="Messages">								<div id="contextMenu" class="contextMenu">									<ul id="items">										<li class="delete_msg">Delete</li>									</ul>								</div>								<img src="https://v2.stringee.com/stringeexchat/sdk/product/css/assets/shadow1.png" class="shadow-top">								<!--<div id="chat_request_waiting"> <p class="vn" tkey="request_waiting"></p></div>  -->								<div class="Messages_list" id="chatHistory">									<!-- <div id="chat_request_waiting">											<p class="vn" style="display:none"><em>YÃªu cáº§u cá»§a quÃ½ khÃ¡ch Ä‘Ã£ Ä‘Æ°á»£c tiáº¿p nháº­n. QuÃ½ khÃ¡ch vui lÃ²ng chá» trong giÃ¢y lÃ¡t</em></p>											<p class="en"  style="display:none"><em>Your request has been received. Please wait a moment</em></p>										</div> -->								</div>								<img src="https://v2.stringee.com/stringeexchat/sdk/product/css/assets/shadow2.png" class="shadow-bottom">							</div>							<div class="Input Input-blank">								<div class="dragdroparea"><span tkey="dragdrop_file"></span></div>								<div class="responsive-input">									<textarea class="message_field" id="message_field" rows="4" tpla="pl_first_msg" placeholder="Type a message here.."></textarea>									<button t class="btn btn-light btn-click-send">										<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Icons" x="0px" y="0px" viewBox="0 0 32 32" style="enable-background:new 0 0 32 32;" xml:space="preserve">											<style type="text/css">												.st0 {													fill: #fff;													stroke-width: 2;													stroke-linecap: round;													stroke-linejoin: round;													stroke-miterlimit: 10;												}												.st1 {													fill: #fff;													stroke-width: 2;													stroke-linejoin: round;													stroke-miterlimit: 10;												}											</style>											<path class="st0" d="M26.4,2.9L3.8,15c-0.7,0.4-0.7,1.5,0.1,1.8l20.8,8.7c0.6,0.3,1.3-0.2,1.4-0.8l1.7-20.8  C27.9,3,27.1,2.5,26.4,2.9z" />											<path class="st0" d="M26,4L13,20v7.3c0,0.9,1.2,1.4,1.8,0.7L19,23" />										</svg>									</button> </div>								<div class="message_actions">									<div class="left stringeex"><a target="_blank" href="https://stringeex.com/">StringeeX</a></div>									<div class="right">										<input type="file" id="file_upload" style="display:none;" />										<button type="button" class="btn btn-light" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="End chat" id="btn_endChat">											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 14 13.99">												<g data-name="Layer 2">													<path d="M8.72,9.28a.47.47,0,0,0-.47.47v2H5.42V2.22H8.26v2a.47.47,0,1,0,.93,0V1.76a.47.47,0,0,0-.47-.47H5.42V.47A.47.47,0,0,0,4.79,0L.31,1.66A.47.47,0,0,0,0,2.1v9.79a.47.47,0,0,0,.31.44L4.79,14,5,14a.47.47,0,0,0,.27-.08.46.46,0,0,0,.2-.38v-.87h3.3a.47.47,0,0,0,.47-.47V9.75A.47.47,0,0,0,8.72,9.28ZM4.49,12.86.93,11.57V2.43L4.49,1.13Z"></path>													<path d="M13.85,6.62l-2-2a.5.5,0,1,0-.7.71l1.11,1.09H6.5a.51.51,0,0,0,0,1h5.77L11.13,8.61a.5.5,0,1,0,.7.71l2-2a.5.5,0,0,0,0-.71Z"></path>												</g>											</svg> <!-- <i class="fa fa-sign-out-alt"></i> -->										</button>										<button type="file" class="btn btn-light" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Attach file" id="btn_attachFile">											<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 14 14">												<path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M6 4.6v5c0 .6.5 1.1 1.1 1.1s1.1-.5 1.1-1.1V2.7C8.2 1.5 7.2.5 6 .5s-2.2 1-2.2 2.2v7.5c0 1.8 1.5 3.3 3.3 3.3s3.3-1.5 3.3-3.3V4.6"></path>											</svg> </button>										<button type="button" class="btn btn-light" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Options" id="btn_options">											<!-- <i class="fa fa-ellipsis-h"></i> -->											<svg xmlns="http://www.w3.org/2000/svg" width="13" height="3" viewBox="0 0 13 3">												<g fill="#000" fill-rule="evenodd">													<circle cx="1.5" cy="1.5" r="1.5"></circle>													<circle cx="6.5" cy="1.5" r="1.5"></circle>													<circle cx="11.5" cy="1.5" r="1.5"></circle>												</g>											</svg> </button>									</div>								</div>							</div>							<div class="modal endChatModal bd-example-modal-lg" tabindex="-1" role="dialog" id="endChatModal" aria-labelledby="endChatModal" aria-hidden="true">								<div class="modal-dialog modal-lg">									<div class="modal-content">										<div class="modal-body" tkey="chat_end_confirm">											Are you sure you want to end this chat?										</div>										<div class="modal-footer">											<button type="button" class="btn btn-secondary btn-sm  cancel" data-dismiss="modal" tkey="btn_cancel">Cancel</button>											<button type="button" class="btn btn-primary btn-sm end" id="endChatModal_btn" tkey="btn_end">End</button>										</div>									</div>								</div>							</div>							<div class="modal " id="modalImage" tabindex="-1" role="dialog" style="padding-left: 0 !important" aria-labelledby="modalImage" aria-hidden="true">								<div class="modal-dialog" role="document">									<div class="modal-content">										<button type="button" class="close" data-dismiss="modal" aria-label="Close">											<span aria-hidden="true">&times;</span>										</button>										<div class="modal-body">										</div>									</div>								</div>							</div>							<div class="modal optionsModal bd-example-modal-lg" tabindex="-1" role="dialog" id="optionsModal" data-keyboard="false" data-backdrop="static" aria-labelledby="optionsModal" aria-hidden="true">								<div class="modal-dialog modal-lg">									<div class="modal-content">										<button type="button" class="close" data-dismiss="modal">&times;</button>										<div class="modal-body">											<div class="list-group">												<a href="#" class="list-group-item toggleSound list-group-item-action">													<span tkey="sound">Sound </span>													<i class="volume-up"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 14 11" style="enable-background:new 0 0 14 11">															<path d="M7 11c-.2 0-.4-.1-.6-.2L3.2 8.2H1c-.6 0-1-.4-1-1V3.7c0-.6.4-1 1-1h2.2l3.2-2.5C6.7 0 7.1 0 7.4.1 7.8.3 8 .6 8 1v9C8 10.6 7.6 11 7 11zM1.1 7.1h2.2c.2 0 .4.1.6.2l3 2.4V1.3l-3 2.4C3.7 3.8 3.5 3.9 3.3 3.9H1.1V7.1zM3.3 8.2L3.3 8.2zM12.6 10c-.1 0-.2 0-.3-.1-.3-.2-.4-.5-.2-.8.5-1.1.8-2.4.8-3.6 0-1.3-.2-2.5-.8-3.6-.1-.3 0-.6.2-.8.3-.1.6 0 .8.2 0 0 0 0 0 0C13.7 2.6 14 4.1 14 5.5c0 1.4-.3 2.9-.9 4.2C13 9.9 12.8 10 12.6 10zM9.9 8.5c-.1 0-.3 0-.4-.1C9.3 8.2 9.2 7.9 9.4 7.6c0 0 0 0 0 0 .5-.6.7-1.3.7-2.1 0-.8-.2-1.5-.7-2.1C9.2 3.2 9.3 2.8 9.5 2.6c0 0 0 0 0 0 .3-.2.6-.2.8.1.6.8 1 1.8 1 2.8 0 1-.4 2-1 2.8C10.2 8.4 10.1 8.5 9.9 8.5z"></path>														</svg></i> <i class="volume-mute"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 14 11" style="enable-background:new 0 0 14 11">															<path d="M7 11c-.2 0-.4-.1-.6-.2L3.2 8.2H1c-.6 0-1-.4-1-1V3.7c0-.6.4-1 1-1h2.2l3.2-2.5C6.7 0 7.1 0 7.4.1 7.8.3 8 .6 8 1v9C8 10.6 7.6 11 7 11zM1.1 7.1h2.2c.2 0 .4.1.6.2l3 2.4V1.3l-3 2.4C3.7 3.8 3.5 3.9 3.3 3.9H1.1V7.1zM3.3 8.2L3.3 8.2zM12.6 5.5l1.2-1.2c.2-.2.2-.6 0-.9s-.6-.2-.9 0l-1.2 1.2-1.2-1.2c-.2-.2-.6-.2-.9 0S9.4 4 9.6 4.2l0 0 1.2 1.2L9.6 6.7c-.2.2-.2.6 0 .9s.6.2.9 0l0 0 1.2-1.2 1.2 1.2c.2.2.6.2.9 0s.2-.6 0-.9l0 0L12.6 5.5z"></path>														</svg></i> </a>												<a href="#" class="list-group-item list-group-item-action  email_chat_btn" tkey="email_trans">Email transcript</a>												<a href="#" class="list-group-item list-group-item-action edit_contact_btn" tkey="edit_cont_det">Edit contact details</a>												<a href="#" class="list-group-item list-group-item-action  back_initial_form" tkey="back_initial">Start over</a>												<a href="#" class="list-group-item btn_endChat list-group-item-action" tkey="end_chat">End chat</a>											</div>										</div>									</div>								</div>							</div>							<div class="modal emailChatModal bd-example-modal-lg" tabindex="-1" role="dialog" id="emailChatModal" aria-labelledby="emailChatModal" aria-hidden="true">								<div class="modal-dialog modal-lg">									<div class="modal-content">										<div class="modal-header" tkey="email_trans">Email chat transcript</div>										<div class="modal-body">											<form novalidate>												<div class="form-group">													<label for="inputEmail_emailchat" tkey="email_address">Email address</label>													<input type="email" class="required form-control" id="inputEmail_emailchat" placeholder="your@email.com" aria-describedby="">													<div class="invalid-feedback">Invalid email address</div>												</div>											</form>										</div>										<div class="modal-footer">											<button type="button" class="btn btn-secondary btn-sm  cancel" data-dismiss="modal" tkey="btn_cancel">Cancel</button>											<button type="button" class="btn btn-primary btn-sm end toggle-disabled" disabled id="sendEmailChat" tkey="btn_submit">Submit</button>										</div>									</div>								</div>							</div>							<div class="modal contactDetailsModal bd-example-modal-lg" tabindex="-1" role="dialog" id="contactDetailsModal" aria-labelledby="contactDetailsModal" aria-hidden="true">								<div class="modal-dialog modal-lg">									<div class="modal-content">										<div class="modal-header" tkey="edit_cont_det">Edit contact details</div>										<div class="modal-body">											<form novalidate>												<div class="form-group inputName_editcontact">													<label for="inputName_editcontact" tkey="your_name">Your name</label>													<input type="text" class="required form-control" placeholder="Your name" name="inputName_editcontact" id="inputName_editcontact" aria-describedby="">													<div class="invalid-feedback"> Name is required</div>												</div>												<div class="form-group inputPhone_editcontact">													<label for="inputPhone_editcontact" tkey="phone_number">Phone number</label>													<input type="tel" class="required form-control" name="inputPhone_editcontact" id="inputPhone_editcontact" aria-describedby="">													<div class="invalid-feedback">Invalid phone number</div>												</div>												<div class="form-group inputEmail_editcontact">													<label for="inputEmail_editcontact" tkey="email_address">Email Address</label>													<input type="email" class="required form-control" name="inputEmail_editcontact" placeholder="your@email.com" id="inputEmail_editcontact" aria-describedby="">													<div class="invalid-feedback">Invalid email address</div>												</div>											</form>										</div>										<div class="modal-footer">											<button type="button" class="btn btn-secondary btn-sm cancel" data-dismiss="modal" tkey="btn_cancel">Cancel</button>											<button type="button" class="btn btn-primary btn-sm end toggle-disabled" disabled id="saveContactDetails" tkey="btn_submit">Submit</button>										</div>									</div>								</div>							</div>							<div class="modal rateCommentModal bd-example-modal-lg" tabindex="-1" role="dialog" id="rateCommentModal" aria-labelledby="rateCommentModal" aria-hidden="true">								<div class="modal-dialog modal-lg">									<div class="modal-content">										<div class="modal-body">											<form novalidate>												<div class="form-group">													<label for="inputName" class="please-rate" tkey="pls_rate_chat">Please rate this chat</label>													<div class="rate_chat_btns">														<button type="button" class="btn_rate_thumbs thumbs_up">															<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">																<g fill="none" stroke="currentColor">																	<path stroke-linejoin="round" d="M14.5 6.5a1 1 0 0 1 1 1c-.1 2.4-.4 8-2 8H5a.47.47 0 0 1-.5-.5V6.9a.55.55 0 0 1 .3-.5c.6-.2 1.7-1 1.7-4.4a1.5 1.5 0 0 1 3 0v4.5z"></path>																	<rect width="2" height="9" x=".5" y="6.5" rx=".5" ry=".5"></rect>																</g>															</svg>														</button>														<button type="button" class="btn_rate_thumbs thumbs_down">															<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">																<g fill="none" stroke="currentColor">																	<path stroke-linejoin="round" d="M1.5 9.5a1 1 0 0 1-1-1c.1-2.4.4-8 2-8H11a.47.47 0 0 1 .5.5v8.1a.55.55 0 0 1-.3.5c-.6.2-1.7 1-1.7 4.4a1.5 1.5 0 0 1-3 0V9.5z"></path>																	<rect width="2" height="9" x="13.5" y=".5" rx=".5" ry=".5"></rect>																</g>															</svg> </button>													</div>												</div>												<div class="form-group">													<label for="inputInfo_ratechat" tkey="leave_comment">Leave a comment(max. 120 characters)</label>													<textarea class="message_field form-control" id="inputInfo_ratechat" rows="4" maxlength="120"></textarea>													<div style="font-style: italic;"><span id="rchars">120</span> <span tkey="limit_comment"> character(s) remaining</span></div>												</div>											</form>										</div>										<div class="modal-footer">											<button type="button" class="btn btn-secondary btn-sm cancel btn_close_rate_chat" data-dismiss="modal" tkey="btn_cancel">Cancel</button>											<button type="button" class="btn btn-primary btn-sm end send" id="rateCommentModal_btn" tkey="btn_submit">Submit</button>										</div>									</div>								</div>							</div>							<div class="alert alert_file_error alert-danger alert-dismissable">								<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>								<div class="info"></div>							</div>						</div>					</div>					<!-- <div class="Messenger_messenger reconnect_chat">							<div class="wrapper">								<p>Please, click the button below to reconnect.</p>								<button  type="button" class="btn btn-light btn_reconnect">Reconnect</button>							</div>						</div> -->				</div>				<div class="chat_on">					<div class="badge">0</div>					<img class="chat_on_img" id="chat_on_img" src="" />				</div>			</div>		</div>	</div></body></html>';
	getContentIframe(iframe_html);

}