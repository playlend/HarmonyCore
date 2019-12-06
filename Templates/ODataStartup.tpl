<CODEGEN_FILENAME>Startup.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.6</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>API_DOCS_PATH</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>API_TITLE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>CONTROLLERS_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_API</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_SERVER</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_HTTPS_PORT</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataEdmBuilder.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Creates a Startup class for an OData / Web API hosting environment
;//
;// Copyright (c) 2018, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;;*****************************************************************************
;;
;; Title:       Startup.dbl
;;
;; Description: Startup class for an OData / Web API hosting environment
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************
;;

import Harmony.AspNetCore
import Harmony.AspNetCore.Context
import Harmony.Core
import Harmony.Core.Context
import Harmony.Core.FileIO
import Harmony.Core.Utility
import Harmony.OData
import Harmony.OData.Adapter
<IF DEFINED_ENABLE_AUTHENTICATION>
import Microsoft.AspNetCore.Authorization
import Microsoft.AspNetCore.Authentication.JwtBearer
</IF DEFINED_ENABLE_AUTHENTICATION>
import Microsoft.AspNetCore.Builder
import Microsoft.AspNetCore.Hosting
import Microsoft.AspNetCore.Http
import Microsoft.AspNetCore.Mvc
import Microsoft.AspNetCore.Mvc.Abstractions
<IF DEFINED_ENABLE_SWAGGER_DOCS>
import Microsoft.AspNetCore.StaticFiles
</IF DEFINED_ENABLE_SWAGGER_DOCS>
import Microsoft.AspNet.OData
import Microsoft.AspNet.OData.Extensions
import Microsoft.AspNet.OData.Builder
import Microsoft.AspNet.OData.Routing
import Microsoft.AspNet.OData.Routing.Conventions
import Microsoft.EntityFrameworkCore
import Microsoft.Extensions.Configuration
import Microsoft.Extensions.DependencyInjection
import Microsoft.Extensions.DependencyInjection.Extensions
import Microsoft.Extensions.Logging
import Microsoft.Extensions.Options
import Microsoft.Extensions.Primitives
<IF DEFINED_ENABLE_AUTHENTICATION>
<IF DEFINED_ENABLE_CUSTOM_AUTHENTICATION>
import Microsoft.IdentityModel.Tokens
</IF DEFINED_ENABLE_CUSTOM_AUTHENTICATION>
</IF DEFINED_ENABLE_AUTHENTICATION>
import Microsoft.OData
import Microsoft.OData.Edm
import Microsoft.OData.UriParser
import System.Collections.Generic
import System.IO
import System.Linq
import System.Text
import System.Threading.Tasks
import <CONTROLLERS_NAMESPACE>
import <MODELS_NAMESPACE>
<IF DEFINED_ENABLE_API_VERSIONING>
import Microsoft.AspNetCore.Mvc.ApiExplorer
import Swashbuckle.AspNetCore.Swagger
</IF DEFINED_ENABLE_API_VERSIONING>

namespace <NAMESPACE>

    ;;; <summary>
    ;;;
    ;;; </summary>
    public partial class Startup

        ;;; <summary>
        ;;; This property will be populated later by the default SelfHostEnvironment class.
        ;;; It wil contain a list of all of the logical names used to locate data files in the repository.
        ;;; This information can be useful if implementing a custom FileSpecResolver class, which is done
        ;;; in the Services Assembly, which is why the collection is defined here.
        ;;; </summary>
        public static readwrite property LogicalNames, @List<string>

        ;; Items provided by dependency injection
        public _env, @IHostingEnvironment
        public _config, @IConfiguration

        ;;; <summary>
        ;;; Constructor
        ;;; </summary>
        ;;; <param name="env">HTTP hosting environment</param>
        ;;; <param name="config">Configuration data</param>
        public method Startup
            env, @IHostingEnvironment
            config, @IConfiguration
        proc
            _env = env
            _config = config
        endmethod

        ;;; <summary>
        ;;; This methoid is used to make services available to the application.
        ;;; These services are typically accessed via dependency injection in controller classes.
        ;;; The primary purpose of the ConfigureServices method is as a place to register
        ;;; implementations of types for services that are needed by the application.
        ;;; It is also used to configure any options related to those services.
        ;;; </summary>
        ;;; <param name="services">Collection of available services.</param>
        public method ConfigureServices, void
            services, @IServiceCollection
        proc
            ;;-------------------------------------------------------
            ;;Enable logging

            data log_level ,Microsoft.Extensions.Logging.LogLevel ,Microsoft.Extensions.Logging.LogLevel.Error

            data logical ,a40
            data logLen ,int ,0
            xcall getlog('ASPNETCORE_LOG_LEVEL',logical,logLen)
            if (logLen)
            begin
                locase logical
                using logical(1:loglen)+' ' select
                ('0 ','trace '),
                    log_level = Microsoft.Extensions.Logging.LogLevel.Trace
                ('1 ','debug '),
                    log_level = Microsoft.Extensions.Logging.LogLevel.Debug
                ('2 ','information '),
                    log_level = Microsoft.Extensions.Logging.LogLevel.Information
                ('3 ','warning '),
                    log_level = Microsoft.Extensions.Logging.LogLevel.Warning
                ('4 ','error '),
                    log_level = Microsoft.Extensions.Logging.LogLevel.Error
                ('5 ','critical '),
                    log_level = Microsoft.Extensions.Logging.LogLevel.Critical
                ('6 ','none '),
                    log_level = Microsoft.Extensions.Logging.LogLevel.None
                (),
                    throw new Exception("Invalid value for logical ODATA_LOG_LEVEL="+logical(1:loglen))
                endusing
            end

            services.AddLogging(lambda(builder) { builder.SetMinimumLevel(log_level) })

            ;;-------------------------------------------------------
            ;;Make AppSettings available as a service

            lambda GetAppSettings(appSettingsInstance)
            begin
                appSettingsInstance.ProcessEnvironmentVariables()
                mreturn true
            end

            ;;Add an AppSettings service.
            ;;To get an instance from DI ask for an @IOptions<AppSettings>
            if(_config != ^null)
                services.AddOptions<AppSettings>().Validate(GetAppSettings).Bind(_config.GetSection("AppSettings"))

            ;;-------------------------------------------------------
            ;;Load Harmony Core

            ;;DataObjectProvider configuration
            lambda AddDataObjectMappings(serviceProvider)
            begin
                data objectProvider = new DataObjectProvider(serviceProvider.GetService<IFileChannelManager>())
                <STRUCTURE_LOOP>
                objectProvider.AddDataObjectMapping<<StructureNoplural>>("<FILE_NAME>", <IF STRUCTURE_ISAM>FileOpenMode.UpdateIndexed</IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>FileOpenMode.UpdateRelative</IF STRUCTURE_RELATIVE>)
                </STRUCTURE_LOOP>
                mreturn objectProvider
            end

            ;;DBContext configuration
            lambda ConfigureDBContext(sp,opts)
            begin
                HarmonyDbContextOptionsExtensions.UseHarmonyDatabase(opts, sp.GetService<IDataObjectProvider>())
            end

            services.AddSingleton<IEdmBuilder, EdmBuilder>()
            services.AddSingleton<IFileChannelManager, FileChannelManager>()
            services.AddSingleton<IDataObjectProvider>(AddDataObjectMappings)
            services.AddDbContextPool<<MODELS_NAMESPACE>.DBContext>(ConfigureDBContext)

            ;;-------------------------------------------------------
            ;;Load OData and ASP.NET

        <IF DEFINED_ENABLE_API_VERSIONING>
            lambda APIVersionConfig(vOptions)
            begin
                vOptions.ReportApiVersions = true
                ;vOptions.AssumeDefaultVersionWhenUnspecified = true
                vOptions.RouteConstraintName = "apiVersion"
                vOptions.DefaultApiVersion = ApiVersion.Parse("1")
            end

            services.AddApiVersioning(APIVersionConfig)
            services.AddOData().EnableApiVersioning()

            lambda oDataApiExplorer(vOptions)
            begin
                ;; add the versioned api explorer, which also adds IApiVersionDescriptionProvider service
                ;; note: the specified format code will format the version as "'v'major[.minor][-status]"
                vOptions.GroupNameFormat = "'v'V"
                vOptions.SubstitutionFormat = "V"

                ;; note: this option is only necessary when versioning by url segment. the SubstitutionFormat
                ;; can also be used to control the format of the API version in route templates
                vOptions.SubstituteApiVersionInUrl = true
            end

            services.AddODataApiExplorer(oDataApiExplorer)
        <ELSE>
            lambda AddAltKeySupport(serviceProvider)
            begin
                data model = EdmBuilder.GetEdmModel(serviceProvider)
                mreturn new UnqualifiedAltKeyUriResolver(model) <IF NOT_DEFINED_ENABLE_CASE_SENSITIVE_URL>{ EnableCaseInsensitive = true }</IF NOT_DEFINED_ENABLE_CASE_SENSITIVE_URL>
            end

            services.AddSingleton<ODataUriResolver>(AddAltKeySupport)

            services.AddOData()
        </IF DEFINED_ENABLE_API_VERSIONING>

            ;;-------------------------------------------------------
            ;;Load our workaround for the fact that OData alternate key support is messed up right now!

            services.AddSingleton<IPerRouteContainer, HarmonyPerRouteContainer>()
            <IF DEFINED_ENABLE_API_VERSIONING>

            lambda SwaggerGenConfig(options)
            begin
                ;; resolve the IApiVersionDescriptionProvider service
                ;; note: that we have to build a temporary service provider here because one has not been created yet
                data provider, @IApiVersionDescriptionProvider, (@IApiVersionDescriptionProvider)services.BuildServiceProvider().GetRequiredService(^typeof(IApiVersionDescriptionProvider))
                data description, @ApiVersionDescription

                ;; add a swagger document for each discovered API version
                ;; note: you might choose to skip or document deprecated API versions differently
                foreach description in provider.ApiVersionDescriptions
                begin
                    data info = new Info()
                    &    {
                    &    Title = "<API_TITLE> " + description.ApiVersion.ToString(),
                    &    Version = description.ApiVersion.ToString(),
                    &    Description = "<API_DESCRIPTION>",
                    &    Contact = new Swashbuckle.AspNetCore.Swagger.Contact() { Name = "<API_CONTACT_NAME>", Email = "<API_CONTACT_EMAIL>" },
                    &    TermsOfService = "<API_TERMS>",
                    &    License = new Swashbuckle.AspNetCore.Swagger.License() { Name = "<API_LICENSE_NAME>", Url = "<API_LICENSE_URL>" }
                    &    }

                    options.SwaggerDoc( description.GroupName, info )
                end

                ;; add a custom operation filter which sets default values
                ;;options.OperationFilter<SwaggerDefaultValues>()

                ;; integrate xml comments
                ;;options.IncludeXmlComments( XmlCommentsFilePath )
            end

            services.AddSwaggerGen(SwaggerGenConfig)
            <ELSE>
                <IF DEFINED_ENABLE_SWAGGER_DOCS>

            services.AddSwaggerGen()
                </IF DEFINED_ENABLE_SWAGGER_DOCS>
            </IF DEFINED_ENABLE_API_VERSIONING>

            lambda MvcCoreConfig(options)
            begin
                options.EnableEndpointRouting = false
            end

            data mvcBuilder = services.AddMvcCore(MvcCoreConfig)
            &    .SetCompatibilityVersion(CompatibilityVersion.Version_2_2 )
            &    .AddDataAnnotations()      ;;Enable data annotations
            &    .AddJsonFormatters()       ;;For PATCH
        <IF DEFINED_ENABLE_SWAGGER_DOCS>
            &    .AddApiExplorer()          ;;Swagger UI
        </IF DEFINED_ENABLE_SWAGGER_DOCS>
            &    .AddApplicationPart(^typeof(IsolatedMethodsBase).Assembly)

        <IF DEFINED_ENABLE_AUTHENTICATION>
          <IF DEFINED_ENABLE_CUSTOM_AUTHENTICATION>
            <IF DEFINED_ENABLE_SIGNALR>
            lambda jwtMessageHook(context)
            begin
                data accessToken = context.Request.Query["access_token"];

                ;; If the request is for our hub...
                data path = context.HttpContext.Request.Path
                if (!string.IsNullOrEmpty(accessToken) && (path.StartsWithSegments(new PathString("<SIGNALR_PATH>"))))
                begin
                    ;; Read the token out of the query string
                    context.Token = accessToken;
                end
                mreturn Task.CompletedTask
            end

            </IF DEFINED_ENABLE_SIGNALR>
            lambda configJwt(o)
            begin
                o.IncludeErrorDetails = true
                o.ClaimsIssuer = "<CUSTOM_JWT_ISSUER>"
                o.Audience = "<CUSTOM_JWT_AUDIENCE>"
                o.TokenValidationParameters = new TokenValidationParameters()
                &    {
                &    ValidateIssuer = true,
                &    ValidIssuer = "<CUSTOM_JWT_ISSUER>",
                &    ValidateAudience = true,
                &    ValidAudience = "<CUSTOM_JWT_AUDIENCE>",
                &    ValidateIssuerSigningKey = true,
                &    IssuerSigningKey = new SymmetricSecurityKey(<OAUTH_KEY>)
                &    }
            <IF DEFINED_ENABLE_SIGNALR>

                data jwtEvents = new JwtBearerEvents()
                o.Events = jwtEvents
                jwtEvents.OnMessageReceived=jwtMessageHook
            </IF DEFINED_ENABLE_SIGNALR>
            end

            lambda authenticationOptions(options)
            begin
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme
            end

            lambda authorizationOptions(options)
            begin
                 options.DefaultPolicy = new AuthorizationPolicyBuilder(JwtBearerDefaults.AuthenticationScheme).RequireAuthenticatedUser().Build()
            end

            services.AddAuthentication(authenticationOptions).AddJwtBearer("Bearer", configJwt)
            mvcBuilder.AddAuthorization(authorizationOptions)
          <ELSE>
            ;;-------------------------------------------------------
            ;;Enable authentication and authorization

            lambda identityServerOptions(options)
            begin
                options.Authority = "<OAUTH_SERVER>"
                options.RequireHttpsMetadata = false
                options.ApiName = "<OAUTH_API>"
            end

            lambda authenticationOptions(options)
            begin
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme
            end

            lambda authorizationOptions(options)
            begin
                options.DefaultPolicy = new AuthorizationPolicyBuilder(JwtBearerDefaults.AuthenticationScheme).RequireAuthenticatedUser().Build()
            end

            services.AddAuthentication(authenticationOptions).AddIdentityServerAuthentication(identityServerOptions)
            mvcBuilder.AddAuthorization(authorizationOptions)
          </IF DEFINED_ENABLE_CUSTOM_AUTHENTICATION>
        </IF DEFINED_ENABLE_AUTHENTICATION>

            ;;-------------------------------------------------------
            ;;Enable HTTP redirection to HTTPS

            lambda httpsConfig(options)
            begin
                options.RedirectStatusCode = StatusCodes.Status307TemporaryRedirect
                options.HttpsPort = <SERVER_HTTPS_PORT>
            end

            services.AddHttpsRedirection(httpsConfig)

        <IF DEFINED_ENABLE_IIS_SUPPORT>
            ;;-------------------------------------------------------
            ;;Enable support for hosting in IIS

            lambda iisOptions(options)
            begin
                options.ForwardClientCertificate = false
            end

            services.Configure<IISOptions>(iisOptions)

        </IF DEFINED_ENABLE_IIS_SUPPORT>
        <IF DEFINED_ENABLE_CORS>
            ;;-------------------------------------------------------
            ;;Add "Cross Origin Resource Sharing" (CORS) support

            services.AddCors()

        </IF DEFINED_ENABLE_CORS>
            ;;If there is a ConfigureServicesCustom method, call it
            ConfigureServicesCustom(services)

        endmethod

        private AppSettingsMonitor, @IDisposable

        ;;; <summary>
        ;;; This method is used to configure the ASP.NET WebApi request pipeline.
        ;;; </summary>
        ;;; <param name="app">IApplicationBuilder component that configures the request pipeline by having middleware added to it.</param>
        ;;; <param name="env">IHostingEnvironment that exposes information about the environment that is hosting the application.</param>
        public method Configure, void
            required in app, @IApplicationBuilder
            required in env, @IHostingEnvironment
            <IF DEFINED_ENABLE_API_VERSIONING>
            required in versionProvider, @IApiVersionDescriptionProvider
            </IF DEFINED_ENABLE_API_VERSIONING>
        proc
            ;;-------------------------------------------------------
            ;;Configure the AppSettings environment

            data optionsMonitorObj, @IOptionsMonitor<AppSettings>, ServiceProviderServiceExtensions.GetService<IOptionsMonitor<AppSettings>>(app.ApplicationServices)
            AppSettingsMonitor = optionsMonitorObj.OnChange(lambda(opts, name) { opts.ProcessEnvironmentVariables() })
            data settings, @AppSettings, ServiceProviderServiceExtensions.GetService<IOptions<AppSettings>>(app.ApplicationServices).Value

            ;;-------------------------------------------------------
            ;;Configure development and production specific components

            if (env.IsDevelopment()) then
            begin
                data loggerFactory = app.ApplicationServices.GetRequiredService<ILoggerFactory>()
                app.UseDeveloperExceptionPage()

                data hc_log_level ,Harmony.Core.Interface.LogLevel ,Harmony.Core.Interface.LogLevel.Debug
                data logical ,a40
                data logLen ,int ,0
                xcall getlog('HARMONY_CORE_LOG_LEVEL',logical,logLen)
                if (logLen)
                begin
                    locase logical
                    using logical(1:loglen)+' ' select
                    ('0 ','trace '),
                        hc_log_level = Harmony.Core.Interface.LogLevel.Trace
                    ('1 ','debug '),
                        hc_log_level = Harmony.Core.Interface.LogLevel.Debug
                    ('2 ','information '),
                        hc_log_level = Harmony.Core.Interface.LogLevel.Info
                    ('3 ','warning '),
                        hc_log_level = Harmony.Core.Interface.LogLevel.Warning
                    ('4 ','error '),
                        hc_log_level = Harmony.Core.Interface.LogLevel.Error
                    ('5 ','critical '),
                        hc_log_level = Harmony.Core.Interface.LogLevel.Critical
                    (),
                        throw new Exception("Invalid value for logical HARMONY_CORE_LOG_LEVEL="+logical(1:loglen))
                    endusing
                end

                DebugLogSession.Logging = new AspNetCoreDebugLogger(loggerFactory.CreateLogger("HarmonyCore")) { Level = hc_log_level }
                app.UseLogging(DebugLogSession.Logging)
            end
            else
            begin
                ;;Enable HTTP Strict Transport Security Protocol (HSTS)
                ;
                ;You need to research this and know what you are doing with this. Here's a starting point:
                ;https://docs.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-2.1&tabs=visual-studio
                ;
                ;app.UseHsts()
            end

            ;;-------------------------------------------------------
            ;;Enable HTTP redirection to HTTPS

            app.UseHttpsRedirection()

        <IF DEFINED_ENABLE_AUTHENTICATION>
            ;;-------------------------------------------------------
            ;;Enable the authentication middleware

            app.UseAuthentication()

        </IF DEFINED_ENABLE_AUTHENTICATION>
            ;;-------------------------------------------------------
            ;;Configure the MVC & OData environments

            lambda mvcBuilder(builder)
            begin
            <IF NOT_DEFINED_ENABLE_API_VERSIONING>
                data model = EdmBuilder.GetEdmModel(app.ApplicationServices)

            </IF NOT_DEFINED_ENABLE_API_VERSIONING>
                lambda UriResolver(s)
                begin
                    data result = app.ApplicationServices.GetRequiredService<ODataUriResolver>()
                    mreturn result
                end

                lambda EnableRouting(configContext)
                begin
                <IF DEFINED_ENABLE_API_VERSIONING>
                    configContext.RoutingConventions.Insert(1, new HarmonySprocRoutingConvention())
                    configContext.RoutingConventions.Insert(1, new AdapterRoutingConvention())
                    mreturn configContext.RoutingConventions
                <ELSE>
                    data routeList = ODataRoutingConventions.CreateDefaultWithAttributeRouting("<SERVER_BASE_PATH>", builder)
                  <IF DEFINED_ENABLE_SPROC>
                    routeList.Insert(0, new HarmonySprocRoutingConvention())
                  </IF DEFINED_ENABLE_SPROC>
                  <IF DEFINED_ENABLE_ADAPTER_ROUTING>
                    routeList.Insert(0, new AdapterRoutingConvention())
                  </IF DEFINED_ENABLE_ADAPTER_ROUTING>
                    mreturn routeList
                </IF DEFINED_ENABLE_API_VERSIONING>
                end

                lambda EnableWritableEdmModel(sp)
                begin
                    mreturn new RefEdmModel() { RealModel = EdmBuilder.GetEdmModel(sp) }
                end

                lambda EnableDI(containerBuilder)
                begin
                    containerBuilder.AddService<Microsoft.OData.UriParser.ODataUriResolver>( Microsoft.OData.ServiceLifetime.Singleton, UriResolver)
                    nop
                end

            <IF DEFINED_ENABLE_API_VERSIONING>
                lambda ConfigureRoute(containerBuilder)
                begin
                    data containerBuilderType, @Type, ((@Object)containerBuilder).GetType()
                    data servicesField, @System.Reflection.FieldInfo, containerBuilderType.GetField("services", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance)
                    data serviceDescriptors = ((@System.Collections.IEnumerable)servicesField.GetValue(containerBuilder)).OfType<ServiceDescriptor>()
                    data versionedModelDescriptor = serviceDescriptors.Where(lambda(descriptor) { descriptor.ServiceType == ^typeof(IEdmModel) }).Last()
                    data versionedModel = versionedModelDescriptor.ImplementationInstance
                    if(versionedModel == ^null)
                        versionedModel = versionedModelDescriptor.ImplementationFactory(app.ApplicationServices)
                    containerBuilder.AddService<IEdmModel>(Microsoft.OData.ServiceLifetime.Scoped, lambda(sp) { new RefEdmModel() { RealModel = ^as(versionedModel, @IEdmModel) }  })
                    containerBuilder.AddService<ODataUriResolver>(Microsoft.OData.ServiceLifetime.Singleton, lambda(sp) { new UnqualifiedAltKeyUriResolver(^as(versionedModel, @IEdmModel)) { EnableCaseInsensitive = true } })
                end
            <ELSE>
                lambda ConfigureRoute(containerBuilder)
                begin
                    containerBuilder.AddService<IEdmModel>(Microsoft.OData.ServiceLifetime.Scoped, EnableWritableEdmModel)
                    containerBuilder.AddService<IEnumerable<IODataRoutingConvention>>(Microsoft.OData.ServiceLifetime.Singleton, EnableRouting)
                end
            </IF DEFINED_ENABLE_API_VERSIONING>

                ;;Enable support for dependency injection into controllers
                builder.EnableDependencyInjection(EnableDI)

                ;;Configure the default OData route
            <IF DEFINED_ENABLE_API_VERSIONING>
                data versionedModels = EdmBuilder.EdmVersions.Select(lambda(versionNumber) { EdmBuilder.GetEdmModel(app.ApplicationServices, versionNumber) }).ToArray()
                builder.MapVersionedODataRoutes("<SERVER_BASE_PATH>", "<SERVER_BASE_PATH>/v{version:apiVersion}", versionedModels, ConfigureRoute, EnableRouting)
            <ELSE>
                builder.MapODataServiceRoute("<SERVER_BASE_PATH>", "<SERVER_BASE_PATH>", ConfigureRoute)
            </IF DEFINED_ENABLE_API_VERSIONING>

                ;;---------------------------------------------------
                ;;Enable optional OData features

            <IF DEFINED_ENABLE_SELECT>
                ;;Enable $select expressions to select properties returned
                builder.Select()

            </IF DEFINED_ENABLE_SELECT>
            <IF DEFINED_ENABLE_FILTER>
                ;;Enable $filter expressions to filter rows returned
                builder.Filter()

            </IF DEFINED_ENABLE_FILTER>
            <IF DEFINED_ENABLE_ORDERBY>
                ;;Enable $orderby expressions to custom sort results
                builder.OrderBy()

            </IF DEFINED_ENABLE_ORDERBY>
            <IF DEFINED_ENABLE_COUNT>
                ;;Enable /$count endpoints
                builder.Count()

            </IF DEFINED_ENABLE_COUNT>
            <IF DEFINED_ENABLE_RELATIONS>
                ;;Enable $expand expressions to expand relations
                builder.Expand()

            </IF DEFINED_ENABLE_RELATIONS>
            <IF DEFINED_ENABLE_TOP>
                ;;Specify the maximum rows that may be returned by $top expressions
                builder.MaxTop(100)

            </IF DEFINED_ENABLE_TOP>
            end

        <IF DEFINED_ENABLE_CORS>
            ;;-------------------------------------------------------
            ;;Add "Cross Origin Resource Sharing" (CORS) support

            lambda corsOptions(builder)
            begin
                builder.AllowAnyOrigin()
                &    .AllowAnyMethod()
                &    .AllowAnyHeader()
            end

            app.UseCors(corsOptions)

        </IF DEFINED_ENABLE_CORS>
            ;;-------------------------------------------------------
            ;;Enable MVC

            ;;If there is a ConfigureCustomBeforeMvc method, call it
            ConfigureCustomBeforeMvc(app,env)

            app.UseMvc(mvcBuilder)

            ;;-------------------------------------------------------
            ;;Configure the web server to serve static files

            ;;Support default files (index.html, etc.)
            app.UseDefaultFiles()

        <IF DEFINED_ENABLE_API_VERSIONING>
            ;;Support serving static files
            app.UseStaticFiles()

        <ELSE>
            ;;Add a media type for YAML files
            data provider = new FileExtensionContentTypeProvider()
            provider.Mappings[".yaml"] = "text/yaml"
            data sfoptions = new StaticFileOptions()
            sfoptions.ContentTypeProvider = provider
            ;;Support serving static files
            app.UseStaticFiles(sfoptions)

        </IF DEFINED_ENABLE_API_VERSIONING>
        <IF DEFINED_ENABLE_API_VERSIONING>
            ;;-------------------------------------------------------
            ;;Configure and enable API versioning

            lambda configureSwaggerUi(config)
            begin
                config.RoutePrefix = "api-docs"
                data description, @ApiVersionDescription
                foreach description in versionProvider.ApiVersionDescriptions
                begin
                    config.SwaggerEndpoint( "/swagger/" + description.GroupName + "/swagger.json", description.GroupName.ToUpperInvariant() )
                end

            end

            app.UseSwagger()
            app.UseSwaggerUI(configureSwaggerUi)

        <ELSE>
            <IF DEFINED_ENABLE_SWAGGER_DOCS>
            ;;-------------------------------------------------------
            ;;Configure and enable SwaggerUI

            lambda configureSwaggerUi(config)
            begin
                config.SwaggerEndpoint("/SwaggerFile.yaml", "<API_TITLE>")
                config.RoutePrefix = "<API_DOCS_PATH>"
                config.DocumentTitle = "<API_TITLE>"
            end

            app.UseSwagger()
            app.UseSwaggerUI(configureSwaggerUi)

            </IF DEFINED_ENABLE_SWAGGER_DOCS>
        </IF DEFINED_ENABLE_API_VERSIONING>
            ;;If there is a ConfigureCustom method, call it
            ConfigureCustom(app,env)

        endmethod

        .region "Partial method extensibility points"

        ;;; <summary>
        ;;; Declare the ConfigueServicesCustom partial method.
        ;;; Developers can implement this method in a partial class to provide custom services.
        ;;; </summary>
        ;;; <param name="services"></param>
        partial method ConfigureServicesCustom, void
            services, @IServiceCollection
        endmethod

        ;;; <summary>
        ;;; Declare the ConfigueCustom partial method
        ;;; Developers can implement this method in a partial class to provide custom configuration.
        ;;; </summary>
        ;;; <param name="app"></param>
        ;;; <param name="env"></param>
        partial method ConfigureCustom, void
            required in app, @IApplicationBuilder
            required in env, @IHostingEnvironment
        endmethod

        ;;; <summary>
        ;;; Declare the ConfigueCustom partial method called immediately before AddMvc
        ;;; Developers can implement this method in a partial class to provide custom configuration.
        ;;; </summary>
        ;;; <param name="app"></param>
        ;;; <param name="env"></param>
        partial method ConfigureCustomBeforeMvc, void
            required in app, @IApplicationBuilder
            required in env, @IHostingEnvironment
        endmethod

        .endregion

    endclass

endnamespace
