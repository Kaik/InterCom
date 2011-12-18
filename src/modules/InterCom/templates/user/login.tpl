{* $Id$ *}
{gt text="Private messaging" assign=ictitle}
{pagesetvar name=title value=$ictitle}

<div id="intercom">
    <h2>{$ictitle}</h2>
    {insert name="getstatusmsg"}

    <div class="z-errormsg">{gt text="Sorry! You need to log in first."}</div>

    <form class="z-form" action="{modurl modname="InterCom" type="user" func="login"}" method="post" enctype="application/x-www-form-urlencoded">
        <div>
            <input type="hidden" name="url" value="{$url}" />

            <fieldset>
                <legend>{gt text="Log in"}</legend>
                <dl class="configrow">

                    {modgetvar module='Users' name='loginviaoption' assign='loginviaoption'}
                    {if $loginviaoption eq 1}
                    <dt><label for="email">{gt text="E-mail address"}:</label></dt>
                    <dd><input type="text" name="email" size="20" maxlength="64" /></dd>
                    {else}
                    <dt><label for="uname">{gt text="User name"}:</label></dt>
                    <dd><input type="text" name="uname" size="20" maxlength="32" /></dd>
                    {/if}

                    <dt><label for="pass">{gt text="Password"}:</label></dt>
                    <dd><input type="password" name="pass" size="20" maxlength="32" /></dd>
                    <dt><label for="rememberme">{gt text="Remember me"}</label></dt>
                    <dd><input type="checkbox" value="1" name="rememberme" id="rememberme" /></dd>
                </dl>
            </fieldset>

            <div class="z-formbuttons">
                <input type="submit" value="{gt text="Log in"}" />
            </div>
        </div>
    </form>
</div>