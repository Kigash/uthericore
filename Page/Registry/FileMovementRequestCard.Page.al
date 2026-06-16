page 50972 "File Movement Request Card"
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

                    trigger OnValidate();
                    begin
                        RegistryFiles.RESET;
                        RegistryFiles.SETRANGE("File No.", Rec."File No.");
                        IF RegistryFiles.FIND('-') THEN BEGIN
                            IF RegistryFiles."File Request Status" = RegistryFiles."File Request Status"::"Issued Out" THEN BEGIN
                                ERROR('The file is currently issued out to %1, kindly request the user to return the file to registry.', RegistryFiles."Current User");
                            END;
                        END;
                    end;
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
                field("Cabinet No."; Rec."Cabinet No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                    Caption = 'From Branch';
                    Editable = false;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    Caption = 'To Branch';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                }
                field("Request Remarks"; Rec."Request Remarks")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Carried By"; Rec."Carried By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Submit Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.SubmitInterBranchTransfer(Rec);
                end;
            }
        }
    }

    var
        User: Record "User Setup";
        //smtprec : Record "409";
        //smtpcu : Codeunit "400";
        bddialog: Dialog;
        mailheader: Text;
        mailbody: Text;
        RegisterLines: Record "Registry Files Line";
        RegistrySetUp: Record "Registry SetUp";
        RegistryFiles: Record "Registry File";
        RegistryManagement: Codeunit "Registry Management2";
}

