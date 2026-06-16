page 50966 "File Issue Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "File Issuance";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Duration Required(Days)"; Rec."Duration Required(Days)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requisiton By"; Rec."Requisiton By")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Carried By"; Rec."Carried By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            part("Registry Files Subform"; 50962)
            {
                Caption = 'Registry Files Request List';
                Editable = false;
                SubPageLink = "Request ID" = FIELD("Request ID");
            }
            group(Remarks)
            {
                field("Approval Comment"; Rec."Approval Comment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issuer Remarks"; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Caption = 'Issuer Remarks';
                }
                field("Issuer ID"; Rec."Issuer ID")
                {
                    ApplicationArea = All;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Rejection Comment"; Rec."Rejection Comment")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Ready For PickUp")
            {
                Image = Shipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.AvailFileForPickup(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Reject Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.RejectFilePickup(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        /*User.GET(USERID);
        IF User."Registry Approver"=TRUE THEN BEGIN
          RegistryApproval:=TRUE;
        END;*/

    end;

    var
        FileRegistry: Record "Registry File";
        Simple: Boolean;
        RegisterLines: Record "Registry Files Line";
        RegistryApproval: Boolean;
        User: Record "User Setup";
        // smtprec : Record "409";
        //smtpcu : Codeunit "400";
        bddialog: Dialog;
        mailheader: Text;
        mailbody: Text;
        RegistryFilesLines: Record "Registry Files Line";
        RegistrySetUp: Record "Registry SetUp";
        ApprovedRequests: Integer;
        RequestsRec: Record "Registry Files Line";
        RegistryManagement: Codeunit "Registry Management2";
}

