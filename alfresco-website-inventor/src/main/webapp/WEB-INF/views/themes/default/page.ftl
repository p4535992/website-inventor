<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>${sitename}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${contextPath}/resource/themes/default/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resource/themes/default/css/custom.css" rel="stylesheet">
</head>
<body>

<#--MAIN NAVIGATION-->
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">${sitename}</a>
        </div>
        <div class="collapse navbar-collapse" id="main-nav">
            <ul class="nav navbar-nav">
                <#list page.categories as category>
                <li><a href="${contextPath}/${siteid}/page/${category.getId()}">${category.name}</a></li>
                </#list>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <header>
            <div>
                <h1>${sitename}<br/><small>${sitedescription}</small></h1>
            </div>
        </header>
    </div>

    <div class="row">
        <#-- BREADCRUMBS -->
        <ol class="breadcrumb">
            <#if page.homepage>
                <li class="active">Home</li>
            <#else>
                <li><a href="${contextPath}/${siteid}">Home</a></li>
                <#list page.breadcrumbs?keys as bcEntry>
                    <li><a href="${contextPath}/${siteid}/page/${page.breadcrumbs[bcEntry]}">${bcEntry}</a></li>
                </#list>
                <li class="active">${page.title}</li>
            </#if>
        </ol>
    </div>

    <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-4">
            <#-- NAVIGATION -->
            <ul class="nav nav-tabs">
                <li class="active">
                    <a aria-expanded="true" href="#link-tab" data-toggle="tab">Links</a>
                </li>
                <li>
                    <a aria-expanded="true" href="#search-tab" data-toggle="tab">Search</a>
                </li>
            </ul>

            <div class="tab-content">
                <div id="link-tab" class="tab-pane fade active in">
                    <div class="list-group table-of-contents">
                        <#if !page.homepage>
                            <a class="list-group-item" href="${contextPath}/${siteid}/page/${page.parentId}">Up</a>
                        </#if>
                        <#list page.links as link>
                            <a class="list-group-item" href="${contextPath}/${siteid}/page/${link.getId()}">${link.name}</a>
                        </#list>
                    </div>
                </div>

                <div id="search-tab" class="tab-pane fade in">
                    <div>
                        <#--<form method="POST" action="${pageContext.request.contextPath}/${siteid}/search" class="form-horizontal">-->
                            <#--<c:forEach varStatus="vs" var="filter" items="${searchFilters.filterItems}" >-->
                                <#--<c:if test="${not empty filter.name}">-->
                                    <#--<div class="form-group">-->
                                        <#--<label>${filter.name}</label>-->
                                        <#--<c:choose>-->
                                            <#--<c:when test="${fn:contains(filter.type, 'TEXT')}">-->
                                                <#--<form:input type="text" class="form-control" path="filterItems[${vs.index}].content" ></form:input>-->
                                            <#--</c:when>-->
                                            <#--<c:when test="${fn:contains(filter.type, 'DATE')}">-->
                                                <#--<form:input type="date" maxlength="10" size="10" class="form-control" path="filterItems[${vs.index}].content" placeholder="gg/mm/aaaa" ></form:input>-->
                                            <#--</c:when>-->
                                            <#--<c:when test="${fn:contains(filter.type, 'NUM')}">-->
                                                <#--<form:input type="number" size="3" class="form-control" path="filterItems[${vs.index}].content" ></form:input>-->
                                            <#--</c:when>-->
                                        <#--</c:choose>-->

                                    <#--</div>-->
                                <#--</c:if>-->
                            <#--</c:forEach>-->
                            <#--<div class="text-right">-->
                                <#--<button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-remove"></span> Cancella</button>-->
                                <#--<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> Cerca</button>-->
                            <#--</div>-->
                        <#--</form>-->
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-9 col-md-9 col-sm-8">
            <#-- CONTENT -->
            <#if page.specialContents['text_header']??>
                <header class="well well-sm">
                    ${page.specialContents['text_header'].properties['text']}
                </header>
            </#if>


            <#list page.contents as content>
                <article>
                    <#switch content.type>
                        <#case "TEXT">
                            <h2>${content.name}</h2>
                            <div>${content.properties['text']}</div>
                        <#break>

                        <#case "IMAGE">
                            <figure>
                                <a href="${contextPath}/proxy/d/${content.id}" class="thumbnail">
                                    <img src="${contextPath}/proxy/r/imgpreview/${content.id}" alt="${content.getName()}" />
                                </a>
                                <figcaption class="caption">
                                    <p>${content.properties['title']!content.properties['name']} (${content.properties['pixelXDimension']} x ${content.properties['pixelYDimension']} - ${content.properties['content_size']}MB)</p>
                                </figcaption>
                            </figure>
                        <#break>

                        <#default>
                            <div class="media margin-bottom-lg">
                                <div class="media-left">
                                    <a href="${contextPath}/proxy/d/${content.id}" target="_blank" class="thumbnail">
                                        <img class="media-object" src="${contextPath}/proxy/r/doclib/${content.id}" alt=""/>
                                    </a>
                                </div>

                                <div class="media-body">
                                    <h4 class="media-heading"><a href="${contextPath}/proxy/d/${content.id}" target="_blank">${content.properties['title']!content.properties['name']}</a></h4>
                                    <#list page.siteProperties.metadata as docprop>
                                        <#switch docprop.type>
                                            <#case "TEXT">
                                                <div><strong>${docprop.label}</strong>: ${content.properties[docprop.propertyId]!"-"}</div>
                                            <#break>

                                            <#case "DATE">
                                                <div><strong>${docprop.label}</strong>: ${content.properties[docprop.propertyId]?number?number_to_date!"-"}</div>
                                            <#break>
                                        </#switch>
                                    </#list>
                                </div>
                            </div>
                    </#switch>
                </article>
            </#list>

            <#if page.specialContents['text_footer']??>
            <header class="well well-sm">
                ${page.specialContents['text_footer'].properties['text']}
            </header>
            </#if>
        </div>
    </div>
</div>

<script src="${contextPath}/resource/themes/default/js/jquery.min.js"></script>
<script src="${contextPath}/resource/themes/default/js/bootstrap.min.js"></script>
<script src="${contextPath}/resource/themes/default/js/scripts.js"></script>
</body>
</html>