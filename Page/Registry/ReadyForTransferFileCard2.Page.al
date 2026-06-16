page 55700 "Ready For Transfer File Card2"
{
    // version CBS-TL,REG

    PageType = Card;
    SourceTable = "File Movement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File Movement ID"; Rec."File Movement ID")
                {
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                }
                field("File Number"; Rec."File Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Cabinet No."; Rec."Cabinet No.")
                {
                    ApplicationArea = All;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    Caption = 'From Branch';
                    ApplicationArea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    Caption = 'To Branch';
                    ApplicationArea = All;
                }
                field("Request Remarks"; Rec."Request Remarks")
                {
                    ApplicationArea = All;
                }
                field("Approval/Rejection Remarks"; Rec."Approval/Rejection Remarks")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    Editable = false;
                }
                field("Released To"; Rec."Released To")
                {
                    ApplicationArea = All;
                }
                field("Carried By"; Rec."Carried By")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Dispatch File")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    User.GET(USERID);
                    Rec.TestField("Released To");
                    IF CONFIRM('Are you sure you want to Dispatch File') THEN BEGIN
                        IF Rec.Status = Rec.Status::"Ready For Transfer" THEN
                            Rec.Status := Rec.Status::Dispatched;
                        MESSAGE('File Dispatched');

                        Rec."Released By" := USERID;
                        Rec."Date Released" := CURRENTDATETIME;

                        //send mail to file requester
                        bddialog.OPEN('Sending email to file requester');
                        User.GET(Rec."Requested By");
                        RegistrySetUp.RESET;
                        RegistrySetUp.GET;
                        mailheader := 'NOTIFICATION OF FILE MOVEMENT APPROVED AND DISPATCHED';
                        mailbody := 'Dear' + Rec."Requested By" + ' <br><br>';
                        mailbody := mailbody + 'Please Note that the following file(s) have been requested for transfer under request ID: <b>' + Rec."File Movement ID" + '</b>have been approved and dipatched. <br><br>';
                        mailbody := mailbody + '<b> File No:' + Rec."File Number" + ' ' + Rec."File Name" + '</b> <br><br>';
                        mailbody := mailbody + 'Released by:' + Rec."Released By" + ' <br><br>';
                        mailbody := mailbody + 'Carried by:' + Rec."Carried By" + ' <br><br>';
                        mailbody := mailbody + 'Please confirm the receipt of the files <br><br>';
                        mailbody := mailbody + 'Kind Regards<br><br>';
                        mailbody := mailbody + '<i>Registry</i><bt><br>';
                        smtprec.RESET;
                        smtprec.GET;
                        smtpcu.CreateMessage('Registry Request', smtprec."User ID", User."E-Mail", mailheader, mailbody, TRUE);
                        //smtpcu.AddBCC('evawaithera4@gmail.com');
                        IF RegistrySetUp."Registry Email" <> '' THEN BEGIN
                            //smtpcu.AddCC(RegistrySetUp."Registry Email");
                        END;
                        smtpcu.Send;

                        bddialog.CLOSE;
                        MESSAGE('Email Sent');
                    END;
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Rec."Released By" := USERID;
        Rec."Date Released" := CURRENTDATETIME;
        //"Released To":="Requested By";
    end;

    var
        User: Record "User Setup";
        smtprec: Record "SMTP Mail Setup";
        smtpcu: Codeunit "SMTP Mail";
        bddialog: Dialog;
        mailheader: Text;
        mailbody: Text;
        RegisterLines: Record "Registry Files Line";
        RegistrySetUp: Record "Registry SetUp";
}

