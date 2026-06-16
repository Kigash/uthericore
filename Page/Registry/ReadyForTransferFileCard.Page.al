page 50976 "Ready For Transfer File Card"
{
    // version TL2.0

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
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    ApplicationArea = All;
                    Caption = 'From Branch';
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    Caption = 'To Branch';
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
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Released To"; Rec."Released To")
                {
                    ApplicationArea = All;
                }
                field("Carried By"; Rec."Carried By")
                {
                    ApplicationArea = All;
                    Visible = true;
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
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.DispatchFile(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Rec."Released By" := USERID;
        Rec."Date Released" := CURRENTDATETIME;
        Rec."Released To" := Rec."Requested By";
    end;

    var
        User: Record "User Setup";
        //smtprec : Record "409";
        // smtpcu : Codeunit "400";
        bddialog: Dialog;
        mailheader: Text;
        mailbody: Text;
        RegisterLines: Record "Registry Files Line";
        RegistrySetUp: Record "Registry SetUp";
        RegistryManagement: Codeunit "Registry Management2";
}

