<?php

/*
 * InterCom Module for Zikula
 *
 * @copyright  InterCom Team
 * @license    GNU/GPL - http://www.gnu.org/copyleft/gpl.html
 * @package    InterCom
 * @see https://github.com/zikula-modules/InterCom
 */

namespace Zikula\IntercomModule\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route; // used in annotations - do not remove
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Zikula\Core\Controller\AbstractController;
use Zikula\ThemeModule\Engine\Annotation\Theme;

/**
 * @Route("messages/notifications")
 */
class NotificationsController extends AbstractController
{
    /**
     * @Route("/list")
     * @Theme("admin")
     * the main administration function
     *
     * @return RedirectResponse
     */
    public function listAction(Request $request)
    {
        if (!$this->hasPermission($this->name.'::', '::', ACCESS_ADMIN)) {
            throw new AccessDeniedException();
        }

        return $this->render('ZikulaIntercomModule:Notifications:list.html.twig', [
        ]);
    }
}
