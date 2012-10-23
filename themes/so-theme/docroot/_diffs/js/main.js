AUI().ready(
	'aui-io-request',
	function(A) {
		var body = A.getBody();

		var toggleFluid = A.one('#toggleFluid');

		if (toggleFluid) {
			toggleFluid.on(
				'click',
				function (event) {
					if (!body.hasClass('so-layout-fluid-ad')) {
						body.toggleClass('so-layout-fluid');

						A.io.request(
							themeDisplay.getPathMain() + '/portal/session_click',
							{
								data: {
									'so-layout-fluid': body.hasClass('so-layout-fluid')
								}
							}
						);
					};
				}
			);
		}

		var memberButton = A.one('#memberButton');

		if (memberButton) {
			memberButton.on(
				'click',
				function (event) {
					event.preventDefault();

					A.io.request(
						event.target.get('href'),
						{
							method: 'POST',
							on: {
								success: function(event, id, obj) {
									window.location = '';
								}
							}
						}
					);
				}
			);
		}
	}
);

AUI().use('aui-base', 'aui-io-request', function(A) {
	var notificationCount = A.one('#dockbar .notification-count');
	var notificationMenuContent = A.one('#_7_WAR_soportlet_notificationsMenuContent');

	notificationMenuContent.delegate(
		'click',
		function(event) {
			if (!event.currentTarget.ancestor('span').hasClass('view-all')) {
				event.preventDefault();

				var row = event.currentTarget.ancestor('.user-notification-event-content');
				var loadingRow = A.Node.create('<div class="loading-animation"></div>');

				row.hide().placeAfter(loadingRow);

				A.io.request(
					event.currentTarget.attr('href'), 
					{
						on: {
							success: function() {
								row.remove();
								loadingRow.remove();
								var notificationCountNumber = notificationCount.get("innerHTML");

								if (notificationCountNumber > 0) {
									notificationCount.set("innerHTML", notificationCountNumber - 1);
									if (notificationCountNumber == 1) {
										A.one('.dismiss-notifications').hide().placeAfter(A.Node.create('<div class="user-notification-event-header"> You have no new notifications. </div>'));
									}
								}
							}
						}
					}
				);
			}
		},
		'a'
	);
});