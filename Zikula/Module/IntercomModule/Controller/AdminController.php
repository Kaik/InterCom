<?php
/**
 * InterCom Module for Zikula
 *
 * @copyright  InterCom Team
 * @license    GNU/GPL - http://www.gnu.org/copyleft/gpl.html
 * @package    InterCom
 * @subpackage User
 *
 * Please see the CREDITS.txt file distributed with this source code for further
 * information regarding copyright.
 */

namespace Zikula\Module\IntercomModule\Controller;

use ModUtil;
use System;
use SecurityUtil;
use ServiceUtil;
use UserUtil;
use Zikula\Core\Controller\AbstractController;

use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route; // used in annotations - do not remove
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method; // used in annotations - do not remove
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\RouterInterface;


/**
 * @Route("/admin")
 */
class AdminController extends \Zikula_AbstractController
{ 
    public function postInitialize()
    {
        $this->view->setCaching(false);
    }

    /**
     * @Route("")
     *
     * the main administration function
     *
     * @return RedirectResponse
     */
    public function indexAction(Request $request)
    {
        // Security check
        if (!SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            throw new AccessDeniedException();
        }
        
        $inbox = $this->entityManager
                    ->getRepository('Zikula\Module\IntercomModule\Entity\MessageEntity')
                    ->getAll(array('inbox' => 1, 'countonly' => true));
        if(is_null($inbox) || !$inbox) {
            $inbox = 0;
        }
   
        $outbox  = $this->entityManager
                    ->getRepository('Zikula\Module\IntercomModule\Entity\MessageEntity')
                    ->getAll(array('outbox' => 1, 'countonly' => true));
        if(is_null($outbox) || !$outbox) {
            $outbox = 0;
        }
        $archive = $this->entityManager
                    ->getRepository('Zikula\Module\IntercomModule\Entity\MessageEntity')
                    ->getAll(array('stored' => 1, 'countonly' => true));
        if(is_null($archive) || !$archive) {
            $archive = 0;
        }
        
        $this->view->assign(array('inbox'              => $inbox,
                'outbox'             => $outbox,
                'archive'            => $archive));

        // Return the output that has been generated by this function
        return new Response($this->view->fetch('Admin/index.tpl'));
    }

    /**
     * @Route("/preferences")
     *
     * @return Response symfony response object
     *
     * @throws AccessDeniedException Thrown if the user doesn't have admin access to the module
     */
    public function preferencesAction(Request $request)
    {
        // Security check
        if (!SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            throw new AccessDeniedException();
        }
        
        if ($request->isMethod('Post')){
            $this->checkCsrfToken();
            
            
            
        }    
        // assign all the module vars
        $this->view->assign($this->getVars());
        // Return the output that has been generated by this function
        return new Response($this->view->fetch('Admin/modifyconfig.tpl'));
    }
    
    /**
     * @Route("/tools")
     *
     * @return Response symfony response object
     *
     * @throws AccessDeniedException Thrown if the user doesn't have admin access to the module
     */
    public function toolsAction(Request $request)
    {
        // Security check
        if (!SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            throw new AccessDeniedException();
        }
        
        if ($request->isMethod('Get')){
           return new Response($this->view->fetch('Admin/tools.tpl'));        
        }        

        $this->checkCsrfToken();
        $dom = ZLanguage::getModuleDomain('InterCom');

        // Get parameters
        $operation = $request->request->get('operation');

        // to do: better information to the user if the action was successful or not! - DONE
        switch ($operation) {
            case "delete_all":
                if (!ModUtil::apiFunc('InterCom', 'admin', 'delete_all')) {
                    return LogUtil::registerError($this->__('Error! Could not delete all messages.'), null, ModUtil::url('InterCom', 'admin', 'tools'));
                }
                else {
                    LogUtil::registerStatus($this->__('Done! Deleted all messages.'));
                }
                break;

            case "delete_inboxes":
                if (!ModUtil::apiFunc('InterCom', 'admin', 'delete_inboxes')) {
                    return LogUtil::registerError($this->__('Error! Could not empty inboxes.'), null, ModUtil::url('InterCom', 'admin', 'tools'));
                }
                else {
                    LogUtil::registerStatus($this->__('Done! Emptied inboxes.'));
                }
                break;

            case "delete_outboxes":
                if (!ModUtil::apiFunc('InterCom', 'admin', 'delete_outboxes')) {
                    return LogUtil::registerError($this->__('Error! Could not empty outboxes.'), null, ModUtil::url('InterCom', 'admin', 'tools'));
                }
                else {
                    LogUtil::registerStatus($this->__('Done! Emptied outboxes.'));
                }
                break;

            case "delete_archives":
                if (!ModUtil::apiFunc('InterCom', 'admin', 'delete_archives')) {
                    return LogUtil::registerError($this->__('Error! Could not empty archives.'), null, ModUtil::url('InterCom', 'admin', 'tools'));
                }
                else {
                    LogUtil::registerStatus($this->__('Done! Emptied archives.'));
                }
                break;

            case "optimize_db":
                if (!ModUtil::apiFunc('InterCom', 'admin', 'optimize_db')) {
                    return LogUtil::registerError($this->__('Error! Could not optimise tables.'), null, ModUtil::url('InterCom', 'admin', 'tools'));
                }
                else {
                    LogUtil::registerStatus($this->__('Done! Optimised tables.'));
                }
                break;

            case "reset_to_defaults":
                if (!ModUtil::apiFunc('InterCom', 'admin', 'default_config')) {
                    return LogUtil::registerError($this->__('Error! Could not reset settings to default values.'), null, ModUtil::url('InterCom', 'admin', 'tools'));
                }
                else {
                    LogUtil::registerStatus($this->__('Done! Reset settings to default values.'));
                }
                break;

            case "import_form_native":
                if (!ModUtil::apiFunc('InterCom', 'init', 'import_form_native')) {
                    return LogUtil::registerError($this->__('Error! Could not import messages from \'Messages\' module.'), null, ModUtil::url('InterCom', 'admin', 'main'));
                }
                else {
                    LogUtil::registerStatus($this->__('Done! Imported messages from the \'Messages\' module.'));
                }
                break;

            default:
                return System::redirect(ModUtil::url('InterCom', 'admin', 'tools'));
                break;
        }
    }
}