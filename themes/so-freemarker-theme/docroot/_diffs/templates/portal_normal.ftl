<!DOCTYPE html>

<#include init />

<html class="<@liferay.language key="lang.dir" />" dir="<@liferay.language key="lang.dir" />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	${theme.include(top_head_include)}
</head>

<body class="${css_class}">

${theme.include(body_top_include)}

<#if is_signed_in>
	<@liferay.dockbar />
</#if>

<div id="wrapper">
	<a href="#main-content" id="skip-to-content">
		<@liferay.language key="skip-to-content" />
	</a>

	<header id="banner" role="banner">
		<hgroup id="heading">
			<div class="company-title">
				<a class="${logo_css_class}" href="${user_dashboard_url}" title="<@liferay.language key="go-to" /> <@liferay.language key="dashboard" />">
					<img alt="${logo_description}" height="${site_logo_height}" src="${site_logo}" width="${site_logo_width}" />
				</a>
			</div>

			<#if !page_group.isUser()>
				<div class="community-title">
					<a href="${community_default_url}" title="<@liferay.language key="go-to" /> ${community_name}">
						<span>${community_name}</span>
					</a>

					<#if is_signed_in>
						<div class="member-button" id="memberButton">
							<#assign member = user_local_service.hasGroupUser(page_group.getGroupId(), user_id)>
							<#assign membership_request = membership_request_local_service.hasMembershipRequest(user_id, page_group.getGroupId(), 0)>

							<#if !member>

								<#if page_group.getType() == 1>
									<#assign join_url = portletURLFactory.create(request, "174", page.getPlid(), "ACTION_PHASE")>
									${join_url.setWindowState("normal")}
									${join_url.setParameter("struts_action", "/sites_admin/edit_site_assignments")}
									${join_url.setParameter("cmd", "group_users")}
									${join_url.setParameter("redirect", community_default_url)}
									${join_url.setParameter("groupId", page_group.getGroupId())}
									${join_url.setParameter("addUserIds", user_id)}

									<span class="action request">
										<a href="${join_url}">
											<@liferay.language key="join-site" />
										</a>
									</span>

								<#elseif page_group.getType() == 2 && !membership_request>
									<#assign membership_request_url = portletURLFactory.create(request, "174", page.getPlid(), "ACTION_PHASE")>
									${membership_request_url.setWindowState("normal")}
									${membership_request_url.setParameter("struts_action", "/sites_admin/post_membership_request")}
									${membership_request_url.setParameter("redirect", community_default_url)}
									${membership_request_url.setParameter("groupId", page_group.getGroupId())}

									<#assign arguments = [user_name, community_name]>
									${membership_request_url.setParameter("comments", languageUtil.format(locale, "x-wishes-to-join-x", arguments.toArray()))}

									<span class="action request">
										<a href="${membership_request_url}">
											<@liferay.language key="request-membership" />
										</a>
									</span>

								<#elseif membership_request>
									<span class="action requested">
										<a>
											<@liferay.language key="membership-requested" />
										</a>
									</span>
								</#if>
							</#if>
						</div>
					</#if>
				</div>
			</#if>

			<h3 class="page-title">
				<span>${the_title}</span>
			</h3>

			<#if is_signed_in>
				<div id="page-search">
					${theme.search()}
				</div>
			</#if>
		</hgroup>

		<#if !is_signed_in>
			<a href="${sign_in_url}" id="sign-in" rel="nofollow">
				${sign_in_text}
			</a>
		</#if>

		<#if is_signed_in>
			<a href="javascript:;" id="toggleFluid">
				<span>
					<@liferay.language key="toggle-fluid-layout" />
				</span>
			</a>
		</#if>
	</header>

	<div id="content">
		<div id="so-sidebar">

			<#if page_group.isUser()>
				<div class="${user_detail_class}">
					<div class="profile-image">
						<a href="${current_user_profile_url}">
							<img src="${current_user_profile_portrait_url}" alt="${current_user_name}">
						</a>
					</div>

					<#if !layout.isPublicLayout()>
						<a class="profile-name" href="${current_user_profile_url}">
							${current_user_name}
						</a>
					</#if>
				</div>
			</#if>

			<#if has_navigation>
				<#include full_templates_path + "/navigation.ftl">
			</#if>

			<#if page_group.isUser()>
				<#include full_templates_path + "/sidebar_portlets.ftl">
			</#if>
		</div>

		<div id="so-context">

			<#if selectable>
				${theme.include(content_include)}

			<#else>
				${portletDisplay.recycle()}

				${portletDisplay.setTitle(the_title)}

				${theme.wrapPortlet("portlet.ftl", content_include)}
			</#if>
		</div>
	</div>

	<footer id="footer" role="contentinfo">
		<p class="powered-by">
			<@liferay.language key="powered-by" />
			<a href="http://www.liferay.com" rel="external">Liferay</a>
		</p>
	</footer>
</div>

${theme.include(body_bottom_include)}

</body>

${theme.include(bottom_include)}

</html>